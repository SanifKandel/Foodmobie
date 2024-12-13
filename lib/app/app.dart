import 'package:flutter/material.dart';
import 'package:foodreminder/app/themes/theme.dart';
import 'package:foodreminder/screen/dashboard/dashboard.dart';
import 'package:foodreminder/screen/dashboard/home/food%20tabs/recommendationDetail.dart';
import 'package:foodreminder/screen/dashboard/home/home_screen.dart';
import 'package:foodreminder/screen/dashboard/home/profile/edit_password.dart';
import 'package:foodreminder/screen/dashboard/home/profile/edit_profile.dart';
import 'package:foodreminder/screen/dashboard/home/profile/user_profile.dart';
import 'package:foodreminder/screen/dashboard/reminder/add_reminder_screen.dart';
import 'package:foodreminder/screen/dashboard/reminder/reminder_detail.dart';
import 'package:foodreminder/screen/dashboard/reminder/update_reminder.dart';
import 'package:foodreminder/screen/dashboard/settings/google_map.dart';
import 'package:foodreminder/screen/home/loginScreen.dart';
import 'package:foodreminder/screen/home/mainScreen.dart';
import 'package:foodreminder/screen/home/registerScreen.dart';
import 'package:foodreminder/screen/dashboard/settings/feedbackScreen.dart';
import 'package:foodreminder/screen/dashboard/settings/about_screen.dart';
import 'package:foodreminder/screen/dashboard/settings/faq_screen.dart';
import 'package:foodreminder/screen/dashboard/home/notification_screen.dart';
import 'package:foodreminder/screen/dashboard/recipe/recipe_details.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/screen/home/splashScreen.dart';
// import 'package:foodreminder/screen/wearos/login.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  DarkThemeProvider themeProvider = DarkThemeProvider();
  @override
  void initState() {
    super.initState();

    getCurrentTheme();
  }

  void getCurrentTheme() async {
    themeProvider.darkTheme = await themeProvider.myPreferences.getTheme();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => themeProvider,
        builder: (context, child) {
          return Consumer<DarkThemeProvider>(builder: (context, value, child) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/',
              theme: ThemeStyles.themeStatus(themeProvider.darkTheme, context),
              title: 'FoodMobie',
              routes: {
                // '/': (context) => const WearLoginScreen(),
                '/': (context) => const SplashScreen(),
                '/mainScreen': (context) => const MainScreen(),
                'Nav': (context) => const DashboardScreen(),
                '/Home': (context) => const HomeScreen(),
                '/RecipeDetail': (context) => const RecipeDetailScreen(),
                '/notification': (context) => const NotificationScreen(),
                '/UserProfile': (context) => const UserProfileScreen(),
                '/AboutScreen': (context) => const AboutScreen(),
                '/FAQScreen': (context) => const FAQScreen(),
                '/Login': (context) => const LoginScreen(),
                '/Register': (context) => const RegisterScreen(),
                '/FeedBack': (context) => const FeedBackScreen(),
                '/EditProfileScreen': (context) => const EditProfileScreen(),
                '/EditPassword': (context) => const EditPasswordScreen(),
                '/GoogleMap': (context) => const GoogleMapScreen(),
                '/AddReminder': (context) => const AddReminderScreen(),
                '/ReminderDetail': (context) => const ReminderDetailScreen(),
                '/ReminderUpdate': (context) => const UpdateReminderScreen(),
                '/RecommendationDetail': (context) =>
                    const RecommendationDetailScreen(),
              },
            );
          });
        });
  }
}
