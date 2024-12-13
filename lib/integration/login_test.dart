import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:foodreminder/main.dart' as app;
import 'package:shared_preferences/shared_preferences.dart';

void main(List<String> args) {
  late final SharedPreferences p;
  
  setUp(() async {
    p = await SharedPreferences.getInstance();
    p.remove("token");
  });

  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Register", (WidgetTester tester) async {
    app.main();
    await tester.pumpAndSettle();
    Finder loginButton = find.byKey(const ValueKey('log'));
    await tester.tap(loginButton);
    await tester.pumpAndSettle();
    Finder emailField = find.byKey(const ValueKey('emailField'));
    await tester.enterText(emailField, "test@test12356.com");
    Finder pwdField = find.byKey(const ValueKey('pwdField'));
    await tester.enterText(pwdField, "test");
    Finder logBtn = find.byKey(const ValueKey('login'));
    await tester.pumpAndSettle();
    await tester.tap(logBtn);

    await tester.pumpAndSettle();
    await Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    String reference = 'Home';
    expect(find.text(reference), findsWidgets);
  });
}
