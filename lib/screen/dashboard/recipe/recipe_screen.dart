import 'package:flutter/material.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/model/food.dart';
import 'package:foodreminder/repository/foods_repository.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:foodreminder/screen/utils/searchbar.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';

class RecipeScreen extends StatefulWidget {
  const RecipeScreen({super.key});

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    _getAllFood();
    super.initState();
  }

  final _foodRepo = FoodsRepositoryImpl();
  final List<Food> _foodList = [];
  List<Food> _searchResults = [];

  void _getAllFood() async {
    _foodList.clear();
    List<Food> foods = await _foodRepo.getAllFoods();
    if (foods.isNotEmpty) {
      _foodList.addAll(foods);
      _searchResults
          .addAll(foods); // add this line to initialize _searchResults
    }
    setState(() {});
  }

  void search(String value) {
    if (value.isEmpty) {
      setState(() {
        _searchResults = _foodList;
      });
    } else {
      List<Food> results = _foodList
          .where(
              (food) => food.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
      setState(() {
        _searchResults = results;
      });
    }
  }

  String searchValue = '';

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Recipes',
          style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: responsiveHeight(context, 0.022, 0.05),
          ),
        ),
        backgroundColor:
            themeProvider.darkTheme ? Colors.grey.shade900 : Colors.teal,
        titleSpacing: 00.0,
        scrolledUnderElevation: 0,
        centerTitle: true,
        toolbarHeight: responsiveHeight(context, 0.072, 0.15),
        toolbarOpacity: 0.8,
        elevation: 0.00,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
        child: Center(
          child: Column(
            children: [
              Container(
                constraints: const BoxConstraints(
                  minWidth: 100,
                  maxWidth: 750,
                ),
                margin: const EdgeInsets.only(top: 16),
                child: SearchBar(
                  onSearch: (value) {
                    setState(() {
                      searchValue = value;
                    });
                    search(searchValue);
                  },
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  child: Container(
                constraints: const BoxConstraints(
                  minWidth: 100,
                  maxWidth: 750,
                ),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child: RefreshIndicator(
                  key: _refreshIndicatorKey,
                  color: Colors.white,
                  backgroundColor: themeProvider.darkTheme
                      ? Colors.teal
                      : Colors.grey.shade900,
                  onRefresh: () async {
                    _getAllFood();
                  },
                  child: _searchResults.isNotEmpty
                      ? ListView.builder(
                          itemCount: _searchResults.length,
                          itemBuilder: (context, index) {
                            Food food = _searchResults[index];
                            return Card(
                              color: themeProvider.darkTheme
                                  ? Colors.grey.shade900
                                  : Colors.teal,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/RecipeDetail',
                                    arguments: food,
                                  );
                                },
                                contentPadding: const EdgeInsets.all(10),
                                leading: SizedBox(
                                  height: responsiveHeight(context, 0.4, 0.12),
                                  width: responsiveWidth(context, 0.3, 0.2),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${Constant.foodImageUrl}${food.image}",
                                      fit: BoxFit.cover,
                                      fadeOutDuration:
                                          const Duration(seconds: 0),
                                      fadeInDuration:
                                          const Duration(seconds: 0),
                                      placeholder: (context, url) => Container(
                                        color: Colors.grey[300],
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                                title: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Padding(
                                        padding: EdgeInsets.only(top: 10)),
                                    Text(
                                      food.name,
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                          fontSize: responsiveHeight(
                                              context, 0.016, 0.06),
                                          fontWeight: FontWeight.w700,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.fastfood,
                                          color: Colors.white70,
                                          size: responsiveHeight(
                                              context, 0.016, 0.06),
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          "${food.calories} calories",
                                          style: TextStyle(
                                              fontSize: responsiveHeight(
                                                  context, 0.016, 0.06),
                                              color: Colors.white70),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : const Center(child: Text("No Result Found")),
                ),
              )),
            ],
          ),
        ),
      ),
    );
  }
}
