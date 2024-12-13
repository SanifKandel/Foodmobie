import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:foodreminder/screen/utils/snackbar.dart';
import 'package:provider/provider.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({Key? key}) : super(key: key);
  static const String route = "aboutScreen";

  @override
  Widget build(BuildContext context) {
    _showalert() {
      showSnackbar(
          context, 'Sorry, the service is currently unavailable.', Colors.red);
    }

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
              background: Image.asset(
                'assets/images/mobie.png',
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
                child: const Text(
                  'About',
                  style: TextStyle(color: Colors.white, fontSize: 16),
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
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'FoodMobie',
                        style: TextStyle(
                            fontSize: responsiveHeight(context, 0.02, 0.04),
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'FoodMobie is a mobile app that helps you discover new and delicious food recommendations. Whether you are looking for breakfast, lunch, or dinner options, FoodMobie has got you covered. The apps food recommendation feature provides you with daily suggestions based on your preferred meal category. You can view the name, image, calorie count, and recipe of each recommendation so you can easily decide what to make for your next meal.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: responsiveHeight(context, 0.015, 0.04)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'FoodMobie also has a convenient food reminder feature that allows you to set reminders for yourself throughout the week. With the ability to add different types of food reminders, you can be sure to never forget what you are going to eat next.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: responsiveHeight(context, 0.015, 0.04)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          'The app also has a recipe feature that provides easy to follow steps, ingredients and other details, so you can cook your favourite dishes at home. FoodMobie is perfect for those who love to explore new foods and are always looking for new and exciting meal ideas. So, it is a one stop solution for all your food needs and will make sure you never have to eat boring food again.',
                          textAlign: TextAlign.justify,
                          style: TextStyle(
                              fontSize: responsiveHeight(context, 0.015, 0.04)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Text(
                          ' Connect With Us',
                          style: TextStyle(
                              color: Colors.teal,
                              fontSize: responsiveHeight(context, 0.02, 0.04)),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/GoogleMap');
                          },
                          child: Text(
                            'Our Location',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: Colors.teal,
                                fontSize:
                                    responsiveHeight(context, 0.02, 0.04)),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          _showalert();
                          // Add code to handle Google icon click
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Image(
                            image: AssetImage('assets/images/insta.png'),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showalert();
                          // Add code to handle Apple icon click
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Image(
                            image: AssetImage('assets/images/whatsapp.png'),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _showalert();
                          // Add code to handle Facebook icon click
                        },
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Image(
                            image: AssetImage('assets/images/facebook.png'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
