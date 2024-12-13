import 'package:flutter/material.dart';
import 'package:foodreminder/repository/user_repository.dart';
import 'package:foodreminder/screen/dashboard/dashboard.dart';
import 'package:foodreminder/screen/home/mainScreen.dart';
import 'package:foodreminder/screen/utils/snackbar.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _loginUser();
  }

  _loginUser() async {
    final islogin = await UserRepositoryImpl().loginUser("email", "password");
    if (islogin) {
      _goToDashboard();
    } else {
      _showMainScreen();
    }
  }

  _goToDashboard() {
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
      showSnackbar(context, 'Login Successful', Colors.teal);
    });
  }

  _showMainScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const MainScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.teal,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/mobie.png",
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 16.0),
              const Text(
                "FoodMobie",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              const Text(
                "A food reminder and recommendation app",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.0,
                ),
              ),
              const SizedBox(height: 16.0),
              const SizedBox(
                width: 350,
                child: LinearProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
