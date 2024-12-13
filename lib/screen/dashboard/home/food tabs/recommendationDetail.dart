import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/model/recommendation.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:foodreminder/app/themes/colors.dart';

class RecommendationDetailScreen extends StatefulWidget {
  static const String route = "recipeDetailScreen";

  const RecommendationDetailScreen({Key? key}) : super(key: key);

  @override
  State<RecommendationDetailScreen> createState() =>
      _RecommendationDetailScreenState();
}

class _RecommendationDetailScreenState
    extends State<RecommendationDetailScreen> {
  late Recommend food;

  @override
  void didChangeDependencies() {
    food = ModalRoute.of(context)!.settings.arguments as Recommend;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark),
            expandedHeight: 275.0,
            backgroundColor: Colors.white,
            elevation: 0.0,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: food.image != null
                  ? CachedNetworkImage(
                      imageUrl: Constant.foodImageUrl + food.image,
                      fit: BoxFit.cover,
                      fadeOutDuration: const Duration(seconds: 0),
                      fadeInDuration: const Duration(seconds: 0),
                      placeholder: (context, url) => Container(
                        color: Colors.grey[300],
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    )
                  : Image.asset(
                      "assets/images/notfound.png",
                      fit: BoxFit.cover,
                    ),
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
            ),
            leadingWidth: 80.0,
            leading: Container(
              margin: const EdgeInsets.only(left: 24.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(56.0),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 3.0, sigmaY: 3.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      height: 56.0,
                      width: 56.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(0.20),
                      ),
                      child: SvgPicture.asset(
                          'assets/icons/arrow-ios-back-outline.svg'),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        food.name,
                        style: TextStyle(
                            fontSize: responsiveHeight(context, 0.024, 0.04),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: responsiveHeight(context, 0.045, 0.12),
                        width: responsiveWidth(context, 0.38, 0.2),
                        margin: const EdgeInsets.only(right: 16.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.timelapse,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                'Time',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        responsiveHeight(context, 0.018, 0.04)),
                              ),
                              const SizedBox(width: 8.0),
                              Container(
                                height: 5.0,
                                width: 5.0,
                                decoration: const BoxDecoration(
                                  color: kSecondaryTextColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              const SizedBox(width: 8.0),
                              Text('${food.time} min',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsiveHeight(
                                          context, 0.018, 0.04))),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        height: responsiveHeight(context, 0.045, 0.12),
                        width: responsiveWidth(context, 0.38, 0.2),
                        margin: const EdgeInsets.only(right: 16.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.teal,
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.fastfood,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 8.0),
                              Text(
                                food.calories,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        responsiveHeight(context, 0.018, 0.04)),
                              ),
                              const SizedBox(width: 4.0),
                              Text('Calories',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsiveHeight(
                                          context, 0.018, 0.04))),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    height: responsiveHeight(context, 0.045, 0.12),
                    width: responsiveWidth(context, 0.4, 0.2),
                    margin: const EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(30)),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.coffee,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 8.0),
                          Text(
                            'Best for',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    responsiveHeight(context, 0.018, 0.04)),
                          ),
                          const SizedBox(width: 4.0),
                          Text(food.meal,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize:
                                      responsiveHeight(context, 0.018, 0.04))),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    'Ingredients',
                    style: TextStyle(
                      fontSize: responsiveHeight(context, 0.024, 0.04),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 24.0,
                        width: 24.0,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 16.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kMainTextColor,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          food.ingredients,
                          style: TextStyle(
                            fontSize: responsiveHeight(context, 0.018, 0.04),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Steps',
                    style: TextStyle(
                      fontSize: responsiveHeight(context, 0.024, 0.04),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 24.0,
                        width: 24.0,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(right: 16.0),
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: kMainTextColor,
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      Expanded(
                        child: Text(
                          food.recipe,
                          style: TextStyle(
                            fontSize: responsiveHeight(context, 0.018, 0.04),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 32.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
