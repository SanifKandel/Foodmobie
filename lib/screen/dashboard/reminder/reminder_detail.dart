import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/model/reminder.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:foodreminder/app/themes/colors.dart';
import 'package:provider/provider.dart';

class ReminderDetailScreen extends StatefulWidget {
  static const String route = "recipeDetailScreen";

  const ReminderDetailScreen({Key? key}) : super(key: key);

  @override
  State<ReminderDetailScreen> createState() => _ReminderDetailScreenState();
}

class _ReminderDetailScreenState extends State<ReminderDetailScreen> {
  late Reminder reminder;

  @override
  void didChangeDependencies() {
    reminder = ModalRoute.of(context)!.settings.arguments as Reminder;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            systemOverlayStyle: const SystemUiOverlayStyle(
                statusBarBrightness: Brightness.dark),
            expandedHeight: 175.0,
            elevation: 0.0,
            pinned: true,
            stretch: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                children: [
                  const SizedBox(
                    height: 70,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/AddReminder',
                      );
                    },
                    child: Column(
                      children: const [
                        Icon(
                          Icons.add_alarm,
                          color: Colors.white,
                          size: 40,
                        ),
                        SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Create New Reminder",
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  )
                ],
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
                        "${reminder.foodname}",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
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
                              const Text(
                                'Time',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
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
                              Text('${reminder.cookingtime} min',
                                  style: const TextStyle(color: Colors.white)),
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
                                "${reminder.calories}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12),
                              ),
                              const SizedBox(width: 4.0),
                              const Text('Calories',
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20.0),
                  Container(
                    height: responsiveHeight(context, 0.045, 0.12),
                    width: responsiveWidth(context, 0.9, 0.42),
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
                            "Reminder for ${reminder.meal}",
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  const Text(
                    'Ingredients',
                    style: TextStyle(fontSize: 18),
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
                          "${reminder.ingredients}",
                          style: const TextStyle(),
                        ),
                      ),
                    ],
                  ),
                  // const SizedBox(height: 16.0),
                  // _buildIngredientItem(context, '4 Eggs'),
                  // _buildIngredientItem(context, '1/2 Butter'),
                  // _buildIngredientItem(context, '1/2 Sugar'),
                  // const Divider(color: kOutlineColor, height: 1.0),
                  const SizedBox(height: 16.0),
                  const Text(
                    'Steps',
                    style: TextStyle(fontSize: 18),
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
                          "${reminder.recipe}",
                          style: const TextStyle(),
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
