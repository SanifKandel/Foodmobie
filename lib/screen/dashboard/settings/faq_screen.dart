import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class FAQScreen extends StatelessWidget {
  const FAQScreen({Key? key}) : super(key: key);
  static const String route = "FAQScreen";

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark),
            expandedHeight: 275.0,
            elevation: 0.0,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Lottie.asset(
                'assets/lottie/think.json',
                fit: BoxFit.cover,
              ),
              stretchModes: const [
                StretchMode.blurBackground,
                StretchMode.zoomBackground,
              ],
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(0.0),
              child: Container(
                height: 32.0,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Colors.teal,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(32.0),
                    topRight: Radius.circular(32.0),
                  ),
                ),
                child: Text(
                  'Help and FAQs',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: responsiveHeight(context, 0.02, 0.06),
                  ),
                ),
              ),
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
                        color: Colors.white.withOpacity(0.20),
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
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: themeProvider.darkTheme
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.question_answer,
                              size: responsiveHeight(context, 0.03, 0.06),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'What is FoodMobie?',
                                style: TextStyle(
                                  fontSize:
                                      responsiveHeight(context, 0.016, 0.04),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'FoodMobie is a mobile app that helps you discover new and delicious food recommendations. Whether you are looking for breakfast, lunch, or dinner options, FoodMobie has got you covered.',
                          style: TextStyle(
                              fontSize: responsiveHeight(context, 0.015, 0.04)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: themeProvider.darkTheme
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.question_answer,
                              size: responsiveHeight(context, 0.03, 0.06),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'How does the food recommendation feature work?',
                                style: TextStyle(
                                  fontSize:
                                      responsiveHeight(context, 0.016, 0.04),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'The food recommendation feature provides users with daily suggestions based on their preferred meal category (breakfast, lunch, or dinner). Users can view the name, image, calorie count, and recipe of each recommendation.',
                          style: TextStyle(
                              fontSize: responsiveHeight(context, 0.015, 0.04)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: themeProvider.darkTheme
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.question_answer,
                              size: responsiveHeight(context, 0.03, 0.06),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'How do I view the calorie count of a food recommendation on FoodMobie?',
                                style: TextStyle(
                                  fontSize:
                                      responsiveHeight(context, 0.016, 0.04),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'The calorie count of a food recommendation can be viewed by going to the food recommendation section in the app. Each recommendation will have the calorie count listed along with the name, image, and recipe.',
                          style: TextStyle(
                              fontSize: responsiveHeight(context, 0.015, 0.04)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: themeProvider.darkTheme
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.question_answer,
                              size: responsiveHeight(context, 0.03, 0.06),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'How accurate are the calorie counts listed on FoodMobie?',
                                style: TextStyle(
                                  fontSize:
                                      responsiveHeight(context, 0.016, 0.04),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'FoodMobie takes care to provide accurate calorie counts for all recommendations, but please note that calorie counts can vary based on the recipe, preparation method, and ingredients used.',
                          style: TextStyle(
                              fontSize: responsiveHeight(context, 0.015, 0.04)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: themeProvider.darkTheme
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.question_answer,
                              size: responsiveHeight(context, 0.03, 0.06),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Can I set my own food reminders in FoodMobie?',
                                style: TextStyle(
                                  fontSize:
                                      responsiveHeight(context, 0.016, 0.04),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Yes, with the Food Reminder feature in FoodMobie, users can set their own food reminders for the week, categorised by Breakfast, Lunch, and Dinner. There is a setup button that opens a reminder screen where users can add different types of food reminders.',
                          style: TextStyle(
                              fontSize: responsiveHeight(context, 0.015, 0.04)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
                Container(
                  decoration: BoxDecoration(
                    color: themeProvider.darkTheme
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.question_answer,
                              size: responsiveHeight(context, 0.03, 0.06),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                'Does FoodMobie have a recipe system?',
                                style: TextStyle(
                                  fontSize:
                                      responsiveHeight(context, 0.016, 0.04),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8.0),
                        Text(
                          'Yes, FoodMobie provides recipe for the food recommendations so users can easily prepare it at home.',
                          style: TextStyle(
                              fontSize: responsiveHeight(context, 0.015, 0.04)),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          ))
        ],
      ),
    );
  }
}
