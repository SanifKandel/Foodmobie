import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:foodreminder/main.dart' as app;

void main(List<String> args) {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  testWidgets("Register", (WidgetTester tester) async {
    app.main();

    await tester.pumpAndSettle();
    Finder registerButton = find.byKey(const ValueKey('reg'));
    await tester.tap(registerButton);
    await tester.pumpAndSettle();
    Finder fnameField = find.byKey(const ValueKey('fnameField'));
    await tester.enterText(fnameField, "test");
    Finder lnameField = find.byKey(const ValueKey('lnameField'));
    await tester.enterText(lnameField, "test");
    Finder emailField = find.byKey(const ValueKey('emailField'));
    await tester.enterText(emailField, "test@test12356.com");
    Finder pwdField = find.byKey(const ValueKey('passwordField'));
    await tester.enterText(pwdField, "test");
    Finder registerBtn = find.byKey(const ValueKey('regBtn'));
    await tester.tap(registerBtn);
    await Future.delayed(const Duration(seconds: 5));
    await tester.pumpAndSettle();

    String reference = 'Sign In';
    expect(find.text(reference), findsWidgets);
  });
}
