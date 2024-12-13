import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodreminder/app/themes/theme_service.dart';
import 'package:foodreminder/screen/home/loginScreen.dart';
import 'package:foodreminder/screen/home/mainScreen.dart';
import 'package:foodreminder/screen/home/registerScreen.dart';
import 'package:provider/provider.dart';

void main() {
  group('User Registration Tests', () {
    testWidgets('MainScreen has Register text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
            // add other providers as needed
          ],
          child: const MaterialApp(
            home: MainScreen(),
          ),
        ),
      );

      // Find the Login text widget
      final loginText = find.text('Register');
      expect(loginText, findsOneWidget);
    });
    testWidgets('Login has Sign In text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
            // add other providers as needed
          ],
          child: const MaterialApp(
            home: LoginScreen(),
          ),
        ),
      );

      // Find the Login text widget
      final loginText = find.text('Sign In');
      expect(loginText, findsOneWidget);
    });

    testWidgets('Register has Sign Up text', (WidgetTester tester) async {
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => DarkThemeProvider()),
            // add other providers as needed
          ],
          child: const MaterialApp(
            home: RegisterScreen(),
          ),
        ),
      );

      // Find the Login text widget
      final loginText = find.text('Sign Up');
      expect(loginText, findsOneWidget);
    });
  });
}
