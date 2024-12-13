import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/screen/dashboard/home/home_screen.dart';
import 'package:foodreminder/screen/dashboard/recipe/recipe_screen.dart';
import 'package:foodreminder/screen/dashboard/reminder/reminder_screen.dart';
import 'package:foodreminder/screen/dashboard/settings/setting.dart';
import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:line_icons/line_icons.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:material_dialogs/widgets/buttons/icon_button.dart';
import 'package:material_dialogs/widgets/buttons/icon_outline_button.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});
  static const String route = "navScreen";

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  void initState() {
    super.initState();
    intiPlatform();
  }

  int _selectedIndex = 0;

  static final List<Widget> _lstScreen = <Widget>[
    const HomeScreen(),
    const ReminderScreen(),
    const RecipeScreen(),
    const SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        bool willLeave = false;
        // show the confirm dialog

        await Dialogs.materialDialog(
            msg: 'Are you sure ? you want to exit',
            title: "Exit FoodMobie",
            color:
                themeProvider.darkTheme ? Colors.grey.shade900 : Colors.white,
            context: context,
            actions: [
              IconsOutlineButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                text: 'Cancel',
                color: Colors.teal,
                iconData: Icons.cancel_outlined,
                textStyle: TextStyle(
                  color: themeProvider.darkTheme
                      ? Colors.grey.shade900
                      : Colors.white,
                ),
                iconColor: themeProvider.darkTheme
                    ? Colors.grey.shade900
                    : Colors.white,
              ),
              IconsButton(
                onPressed: () {
                  willLeave = true;
                  Navigator.of(context).pop();
                  SystemNavigator.pop();
                },
                text: 'Confirm',
                iconData: Icons.exit_to_app,
                color: Colors.grey,
                textStyle: const TextStyle(color: Colors.white),
                iconColor: Colors.white,
              ),
            ]);
        return willLeave;
      },
      child: Scaffold(
        body: Center(
          // index: _selectedIndex,
          // children: _lstScreen,
          child: _lstScreen[_selectedIndex],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color:
                themeProvider.darkTheme ? Colors.grey.shade900 : Colors.white,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(15),
            ),
            boxShadow: const [
              BoxShadow(
                blurRadius: 0.2,
                color: Colors.black45,
              )
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
              child: GNav(
                rippleColor: Colors.teal[300]!,
                hoverColor: Colors.teal[100]!,
                gap: 8,
                activeColor: Colors.white,
                iconSize: responsiveHeight(context, 0.032, 0.08),
                textStyle: TextStyle(
                    fontSize: responsiveHeight(context, 0.020, 0.06),
                    color: Colors.white),
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: const Duration(milliseconds: 200),
                tabBackgroundColor: Colors.teal[300]!,
                tabs: const [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                  ),
                  GButton(
                    icon: LineIcons.alternateList,
                    text: 'Reminder',
                  ),
                  GButton(
                    icon: LineIcons.coffee,
                    text: 'Recipes',
                  ),
                  GButton(
                    icon: LineIcons.cog,
                    text: 'Settings',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> intiPlatform() async {
    await OneSignal.shared.setAppId("9f6634b0-2cc3-45e3-acd2-aa0a46dd481a");
    await OneSignal.shared
        .getDeviceState()
        .then((value) => {print(value!.userId)});
  }
}
