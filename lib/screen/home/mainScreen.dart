import 'package:flutter/material.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/screen/home/loginScreen.dart';
import 'package:foodreminder/screen/home/registerScreen.dart';

import 'package:foodreminder/screen/utils/responsive_utils.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static const String route = "mainScreen";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<DarkThemeProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Food',
                      style: TextStyle(
                        color: Colors.teal,
                        fontSize: responsiveHeight(context, 0.04, 0.08),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: 'Mobie',
                      style: TextStyle(
                        color: themeProvider.darkTheme
                            ? Colors.white
                            : Colors.black87,
                        fontSize: responsiveHeight(context, 0.04, 0.08),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Image.asset(
              'assets/images/mobie.png',
              height: responsiveHeight(context, 0.5, 0.8),
              width: responsiveWidth(context, 0.95, 0.4),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                'Get recommendations for all varieties of Foods',
                style: TextStyle(
                  fontFamily: "Poppins",
                  fontSize: responsiveHeight(context, 0.035, 0.08),
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: Text(
                'Explore all the most delicious foods based on your interest and add to reminder   ',
                style: TextStyle(
                    fontFamily: "Poppins",
                    fontSize: responsiveHeight(context, 0.017, 0.04),
                    fontWeight: FontWeight.w500,
                    color: const Color.fromRGBO(153, 153, 153, 1)),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: responsiveHeight(context, 0.07, 0.2),
                  width: responsiveWidth(context, 0.45, 0.35),
                  child: ElevatedButton(
                    key: const ValueKey("log"),
                    style: const ButtonStyle(),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()));
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  height: responsiveHeight(context, 0.07, 0.2),
                  width: responsiveWidth(context, 0.45, 0.35),
                  child: ElevatedButton(
                    key: const ValueKey('reg'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      elevation: 8,
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const RegisterScreen()));
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
