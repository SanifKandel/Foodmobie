import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/app/network_connectivity.dart';
import 'package:foodreminder/data_source/local_data_source/user_data_source.dart';
import 'package:foodreminder/data_source/remote_data_source/user_remote_data_source.dart';
import 'package:foodreminder/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

abstract class UserRepository {
  // Future<List<User>> getUsers();
  Future<int> addUser(File? file, User user);
  Future<int> updateUser(File? file, User user);
  Future<User> getCurrentUser();
  Future<bool> loginUser(String email, String password);
  Future<int> deleteUser(String userId);
}

class UserRepositoryImpl extends UserRepository {
  @override
  Future<int> addUser(File? file, User user) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return UserRemoteDataSource().addUser(file, user);
    } else {
      return UserDataSource().addUser(file, user);
    }
  }

  @override
  Future<int> updateUser(File? file, User user) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      return UserRemoteDataSource().updateUser(file, user);
    } else {
      throw Exception("no local datasource");
    }
  }

  @override
  Future<int> deleteUser(String userId) async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      int result = await UserRemoteDataSource().deleteUser(userId);
      if (result == 1) {
        final prefs = await SharedPreferences.getInstance();
        bool success = await prefs.remove('token');
        if (success) {
          Constant.token = '';
        }
      }
      return result;
    } else {
      throw Exception("no local datasource");
    }
  }

  @override
  Future<User> getCurrentUser() async {
    bool status = await NetworkConnectivity.isOnline();
    if (status) {
      User user = await UserRemoteDataSource().getCurrentUser();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('fname', user.firstName!);
      prefs.setString('lname', user.lastName!);
      prefs.setString('email', user.email!);
      // prefs.setString('image', user.image!);
      return user;
    } else {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? fname = prefs.getString('fname');
      String? lname = prefs.getString('lname');
      String? email = prefs.getString('email');
      // String? image = prefs.getString('image');
      if (fname != null && lname != null && email != null) {
        User user = User(firstName: fname, lastName: lname, email: email);
        return user;
      } else {
        print("error");
        throw Exception('error');
      }
    }
  }

  @override
  Future<bool> loginUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    if (token != null) {
      Constant.token = token;
      return true;
    } else {
      bool status = await NetworkConnectivity.isOnline();
      if (status) {
        return UserRemoteDataSource().loginUser(email, password);
      } else {
        return UserDataSource().loginUser(email, password);
      }
    }
  }

  Future<bool> logoutUser() async {
    final prefs = await SharedPreferences.getInstance();
    bool success = await prefs.remove('token');
    if (success) {
      Constant.token = '';
      return true;
    } else {
      return false;
    }
  }
}
