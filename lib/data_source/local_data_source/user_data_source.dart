import 'package:foodreminder/helper/objectbox.dart';
import 'package:foodreminder/model/user.dart';
import 'package:foodreminder/state/objectbox_state.dart';
import 'dart:io';

class UserDataSource {
  ObjectBoxInstance get objectBoxInstance => ObjectBoxState.objectBoxInstance!;

  Future<int> addUser(File? file, User user) async {
    try {
      return objectBoxInstance.addUser(user);
    } catch (e) {
      return Future.value(0);
    }
  }

  Future<List<User>> getUsers() {
    try {
      return Future.value(objectBoxInstance.getAllUser());
    } catch (e) {
      throw Exception("Error in getting all users");
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      if (objectBoxInstance.loginUser(email, password) != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Error occured : ${e.toString()}');
    }
  }
}
