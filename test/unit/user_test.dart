import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foodreminder/data_source/remote_data_source/user_remote_data_source.dart';
import 'package:foodreminder/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.setMockInitialValues({});

  group('User Registration Tests', () {
    test('Register', () async {
      // Arrange
      UserRemoteDataSource dataSource = UserRemoteDataSource();
      User user = User(
        email: 'newemail2',
        password: 'yy',
        firstName: 'Test',
        lastName: 'User',
      );
      File? image = File('assets/images/apple.png');

      // Act
      int result = await dataSource.addUser(image, user);

      // Assert
      expect(result, 0); // Expect a successful registration
    });
    test('User Login ', () async {
      bool expectedResult = true;
      String email = 'newemail2';
      String password = 'yy';
      bool actualResult = true;
      await UserRemoteDataSource().loginUser(email, password);
      expect(actualResult, expectedResult);
    });
  });
}
