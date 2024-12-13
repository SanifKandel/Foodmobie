import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/model/recommendation.dart';
import 'package:foodreminder/repository/recommend_repository.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:provider/provider.dart';

class RecommendationBreakfastCard extends StatefulWidget {
  const RecommendationBreakfastCard({super.key});

  @override
  State<RecommendationBreakfastCard> createState() =>
      _RecommendationBreakfastCardState();
}

class _RecommendationBreakfastCardState
    extends State<RecommendationBreakfastCard> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
            future: RecommendRepositoryImpl().getRecommendedBreakfastFood(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Recommend> foods = snapshot.data!;
                return ListView.builder(
                  itemCount: foods.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    Recommend food = foods[index];
                    return Card(
                      color: themeProvider.darkTheme
                          ? Colors.grey.shade900
                          : Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Slidable(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/RecommendationDetail',
                              arguments: food,
                            );
                          },
                          leading: SizedBox(
                            height: responsiveHeight(context, 0.05, 0.12),
                            width: responsiveWidth(context, 0.12, 0.06),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: Constant.foodImageUrl + food.image,
                                  fit: BoxFit.cover,
                                  fadeOutDuration: const Duration(seconds: 0),
                                  fadeInDuration: const Duration(seconds: 0),
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey[300],
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                food.name,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize:
                                        responsiveHeight(context, 0.016, 0.04),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${food.calories} Calories',
                                style: TextStyle(
                                    fontSize:
                                        responsiveHeight(context, 0.015, 0.035),
                                    color: Colors.white70),
                              ),
                            ],
                          ),
                          trailing: SizedBox(
                            child: IconButton(
                              icon: Icon(
                                Icons.coffee,
                                color: themeProvider.darkTheme
                                    ? Colors.white70
                                    : Colors.white,
                                size: responsiveHeight(context, 0.03, 0.1),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              // else if (snapshot.hasError) {
              //   return Text("${snapshot.error}");
              // }
              return const Center(
                  child: Text("Service Not Available, We Are Working on it"));
            });
      },
    );
  }
}

class RecommendationLunchCard extends StatefulWidget {
  const RecommendationLunchCard({super.key});

  @override
  State<RecommendationLunchCard> createState() =>
      _RecommendationLunchCardState();
}

class _RecommendationLunchCardState extends State<RecommendationLunchCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    super.build(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
            future: RecommendRepositoryImpl().getRecommendedLunchFood(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Recommend> foods = snapshot.data!;
                return ListView.builder(
                  itemCount: foods.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    Recommend food = foods[index];
                    return Card(
                      color: themeProvider.darkTheme
                          ? Colors.grey.shade900
                          : Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Slidable(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/RecommendationDetail',
                              arguments: food,
                            );
                          },
                          leading: SizedBox(
                            height: responsiveHeight(context, 0.05, 0.12),
                            width: responsiveWidth(context, 0.12, 0.06),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: Constant.foodImageUrl + food.image,
                                  fit: BoxFit.cover,
                                  fadeOutDuration: const Duration(seconds: 0),
                                  fadeInDuration: const Duration(seconds: 0),
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey[300],
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                food.name,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize:
                                        responsiveHeight(context, 0.016, 0.04),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${food.calories} Calories',
                                style: TextStyle(
                                    fontSize:
                                        responsiveHeight(context, 0.015, 0.035),
                                    color: Colors.white70),
                              ),
                            ],
                          ),
                          trailing: SizedBox(
                            child: IconButton(
                              icon: Icon(
                                Icons.coffee,
                                color: themeProvider.darkTheme
                                    ? Colors.white70
                                    : Colors.white,
                                size: responsiveHeight(context, 0.03, 0.1),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              // else if (snapshot.hasError) {
              //   return Text("${snapshot.error}");
              // }
              return const Center(
                  child: Text("Service Not Available, We Are Working on it"));
            });
      },
    );
  }
}

class RecommendationDinnerCard extends StatefulWidget {
  const RecommendationDinnerCard({super.key});

  @override
  State<RecommendationDinnerCard> createState() =>
      _RecommendationDinnerCardState();
}

class _RecommendationDinnerCardState extends State<RecommendationDinnerCard>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return FutureBuilder(
            future: RecommendRepositoryImpl().getRecommendedDinnerFood(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Recommend> foods = snapshot.data!;
                return ListView.builder(
                  itemCount: foods.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (BuildContext context, index) {
                    Recommend food = foods[index];
                    return Card(
                      color: themeProvider.darkTheme
                          ? Colors.grey.shade900
                          : Colors.teal,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Slidable(
                        child: ListTile(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              '/RecommendationDetail',
                              arguments: food,
                            );
                          },
                          leading: SizedBox(
                            height: responsiveHeight(context, 0.05, 0.12),
                            width: responsiveWidth(context, 0.12, 0.06),
                            child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: CachedNetworkImage(
                                  imageUrl: Constant.foodImageUrl + food.image,
                                  fit: BoxFit.cover,
                                  fadeOutDuration: const Duration(seconds: 0),
                                  fadeInDuration: const Duration(seconds: 0),
                                  placeholder: (context, url) => Container(
                                    color: Colors.grey[300],
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )),
                          ),
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.only(top: 10)),
                              Text(
                                food.name,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontSize:
                                        responsiveHeight(context, 0.016, 0.04),
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${food.calories} Calories',
                                style: TextStyle(
                                    fontSize:
                                        responsiveHeight(context, 0.015, 0.035),
                                    color: Colors.white70),
                              ),
                            ],
                          ),
                          trailing: SizedBox(
                            child: IconButton(
                              icon: Icon(
                                Icons.coffee,
                                color: themeProvider.darkTheme
                                    ? Colors.white70
                                    : Colors.white,
                                size: responsiveHeight(context, 0.03, 0.1),
                              ),
                              onPressed: () {},
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              //  else if (snapshot.hasError) {
              //   return Text("${snapshot.error}");
              // }
              return const Center(
                  child: Text("Service Not Available, We Are Working on it"));
            });
      },
    );
  }
}
