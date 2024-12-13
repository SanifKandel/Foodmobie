import 'dart:async';

import 'package:all_sensors2/all_sensors2.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/model/notification.dart';
import 'package:foodreminder/model/reminder.dart';
import 'package:foodreminder/model/user.dart';
import 'package:foodreminder/repository/notification_repository.dart';
import 'package:foodreminder/repository/reminder_repository.dart';
import 'package:foodreminder/repository/user_repository.dart';
import 'package:foodreminder/screen/dashboard/home/food%20tabs/recommendationMeal.dart';
import 'package:foodreminder/screen/dashboard/home/food%20tabs/remindermeal.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:badges/badges.dart' as badges;
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const String route = "homeScreen";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  int _selectedIndexRecommendation = 0;
  final PageController _pageControllerRecommendation =
      PageController(initialPage: 0);

  final List<Widget> _recommendation = [
    const RecommendationBreakfastCard(),
    const RecommendationLunchCard(),
    const RecommendationDinnerCard(),
  ];

  final List<Reminder> _reminderList = [];
  final _reminderRepo = ReminderRepositoryImpl();
  void _getAllReminder() async {
    _reminderList.clear();
    List<Reminder> reminders = await _reminderRepo.getAllReminders();
    if (reminders.isNotEmpty) {
      _reminderList.addAll(reminders);
    }
    setState(() {});
  }

  final List<double> _accelerometerValue = [];
  final List<StreamSubscription<dynamic>> _streamSubscription = [];
  bool _isDialogOpen = false; // add this line to initialize the flag
  StreamSubscription? _accelerometerSubscription;
  @override
  void initState() {
    super.initState();
    _accelerometerSubscription = accelerometerEvents!.listen((event) {
      if (event.x > 5 && event.y > 5 && event.z > 5 && !_isDialogOpen) {
        _isDialogOpen = true;
        Dialogs.bottomMaterialDialog(
          isDismissible: true,
          msg:
              'Experienced an issue? Tap the button below to send us a report. Your feedback helps us improve FoodMobie.',
          title: 'Feedback',
          context: context,
          actions: [
            IconsButton(
              onPressed: () {
                _isDialogOpen = false;
                Navigator.pushNamed(context, '/FeedBack');
              },
              text: 'Give a Feedback',
              iconData: Icons.feedback,
              color: Colors.teal,
              textStyle: const TextStyle(color: Colors.white),
              iconColor: Colors.white,
            )
          ],
          onClose: (value) {
            _isDialogOpen = false;
          },
        );
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _accelerometerSubscription?.cancel();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final themeProvider = Provider.of<DarkThemeProvider>(context);

    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            toolbarHeight: responsiveHeight(context, 0.072, 0.15),
            toolbarOpacity: 1,
            backgroundColor:
                themeProvider.darkTheme ? Colors.grey.shade900 : Colors.teal,
            elevation: 0,
            scrolledUnderElevation: 0,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: FutureBuilder(
                future: UserRepositoryImpl().getCurrentUser(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    User currentUser = snapshot.data!;
                    return Text(
                      "Hello, ${currentUser.firstName}",
                      style: TextStyle(
                          fontSize: responsiveHeight(context, 0.022, 0.05),
                          fontWeight: FontWeight.normal),
                    );
                  } else {
                    return Text("",
                        style: TextStyle(
                            fontSize: responsiveHeight(context, 0.022, 0.05),
                            fontWeight: FontWeight.normal));
                  }
                }),
            actions: [
              FutureBuilder(
                  future: NotificationsRepositoryImpl().getAllNotifications(),
                  builder: (BuildContext context, snapshot) {
                    if (snapshot.hasData) {
                      List<FoodMobieNotification> notification = snapshot.data!;
                      return Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/notification',
                                arguments: notification);
                          },
                          child: badges.Badge(
                            badgeContent: Text(
                              "${notification.length}",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize:
                                    responsiveHeight(context, 0.015, 0.03),
                              ),
                            ),
                            child: Icon(
                              Icons.notifications,
                              color: themeProvider.darkTheme
                                  ? Colors.white70
                                  : Colors.white,
                              size: responsiveHeight(context, 0.045, 0.09),
                            ),
                          ),
                        ),
                      );
                    } else if (snapshot.hasError) {
                      return Text("${snapshot.error}");
                    }
                    return Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: InkWell(
                        child: badges.Badge(
                          badgeContent: Text(
                            "0",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: responsiveHeight(context, 0.015, 0.03),
                            ),
                          ),
                          child: Icon(
                            Icons.notifications,
                            color: themeProvider.darkTheme
                                ? Colors.white70
                                : Colors.white,
                            size: responsiveHeight(context, 0.045, 0.09),
                          ),
                        ),
                      ),
                    );
                  }),
              const SizedBox(
                width: 20,
              ),
              FutureBuilder(
                future: UserRepositoryImpl().getCurrentUser(),
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    User currentUser = snapshot.data!;
                    if (currentUser.image != null) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/UserProfile',
                              arguments: currentUser);
                        },
                        child: SizedBox(
                          height: responsiveHeight(context, 0.05, 0.12),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                imageUrl:
                                    "${Constant.foodImageUrl}${currentUser.image}",
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
                      );
                    } else {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/UserProfile',
                              arguments: currentUser);
                        },
                        child: Container(
                          height: responsiveHeight(context, 0.05, 0.12),
                          width: responsiveWidth(context, 0.1, 0.06),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                            image: const DecorationImage(
                              image: AssetImage("assets/images/user.png"),
                            ),
                          ),
                        ),
                      );
                    }
                  } else {
                    return Container(
                      height: responsiveHeight(context, 0.045, 0.12),
                      width: responsiveWidth(context, 0.1, 0.06),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                        image: const DecorationImage(
                          image: AssetImage("assets/images/user.png"),
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(
                width: 12.0,
              )
            ],
          ),
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            color: Colors.white,
            backgroundColor:
                themeProvider.darkTheme ? Colors.teal : Colors.grey.shade900,
            onRefresh: () async {
              _getAllReminder();
            },
            child: SingleChildScrollView(
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(
                    minWidth: 100,
                    maxWidth: 750,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Today's Recommendation",
                                style: TextStyle(
                                  fontSize:
                                      responsiveHeight(context, 0.022, 0.05),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () {},
                                child: Text(
                                  "Explore",
                                  style: TextStyle(
                                      fontSize: responsiveHeight(
                                          context, 0.020, 0.06),
                                      color: Colors.teal,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: responsiveHeight(context, 0.045, 0.12),
                                width: responsiveWidth(context, 0.25, 0.15),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        _selectedIndexRecommendation == 0
                                            ? Colors.teal
                                            : Colors.grey.shade900,
                                    elevation: 8,
                                  ),
                                  onPressed: () {
                                    _pageControllerRecommendation.animateToPage(
                                        0,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  child: Text(
                                    "Breakfast",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: responsiveHeight(
                                          context, 0.015, 0.03),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              SizedBox(
                                height: responsiveHeight(context, 0.045, 0.12),
                                width: responsiveWidth(context, 0.25, 0.15),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        _selectedIndexRecommendation == 1
                                            ? Colors.teal
                                            : Colors.grey.shade900,
                                    elevation: 8,
                                  ),
                                  onPressed: () {
                                    _pageControllerRecommendation.animateToPage(
                                        1,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  child: Text(
                                    "Lunch",
                                    style: TextStyle(
                                      fontSize: responsiveHeight(
                                          context, 0.015, 0.03),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 18),
                              SizedBox(
                                height: responsiveHeight(context, 0.045, 0.12),
                                width: responsiveWidth(context, 0.25, 0.15),
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        _selectedIndexRecommendation == 2
                                            ? Colors.teal
                                            : Colors.grey.shade900,
                                    elevation: 8,
                                  ),
                                  onPressed: () {
                                    _pageControllerRecommendation.animateToPage(
                                        2,
                                        duration:
                                            const Duration(milliseconds: 500),
                                        curve: Curves.ease);
                                  },
                                  child: Text(
                                    "Dinner",
                                    style: TextStyle(
                                      fontSize: responsiveHeight(
                                          context, 0.015, 0.03),
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            height: responsiveHeight(context, 0.28, 0.65),
                            child: PageView(
                              physics: const BouncingScrollPhysics(),
                              controller: _pageControllerRecommendation,
                              onPageChanged: (index) {
                                setState(() {
                                  _selectedIndexRecommendation = index;
                                });
                              },
                              children: _recommendation,
                            ),
                          ),
                          const Divider(),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Today's Reminders",
                                style: TextStyle(
                                  fontSize:
                                      responsiveHeight(context, 0.022, 0.05),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/AddReminder',
                                  );
                                },
                                child: Text(
                                  "Add New",
                                  style: TextStyle(
                                      fontSize: responsiveHeight(
                                          context, 0.020, 0.06),
                                      color: Colors.teal,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          const ReminderCard()
                        ]),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
