import 'dart:io';

import 'package:dio/dio.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/data_source/remote_data_source/response/login_response.dart';
import 'package:foodreminder/data_source/remote_data_source/response/user_response.dart';
import 'package:foodreminder/helper/http_service.dart';
import 'package:foodreminder/model/user.dart';
import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class UserRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> addUser(File? file, User user) async {
    try {
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        );
      }
      FormData formData = FormData.fromMap({
        'email': user.email,
        'password': user.password,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'userImage': image,
        // 'food': user.food.map((food) => food.foodId).toList(),
      });
      Response response = await _httpServices.post(
        Constant.userURL,
        data: formData,
      );
      if (response.statusCode == 201) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<int> updateUser(File? file, User user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');
      MultipartFile? image;
      if (file != null) {
        var mimeType = lookupMimeType(file.path);
        image = await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
          contentType: MediaType("image", mimeType!.split("/")[1]),
        );
      }

      final formData = FormData.fromMap({
        'email': user.email,
        'firstName': user.firstName,
        'lastName': user.lastName,
        'userName': user.userName,
        'userImage': image,
      });
      Response response =
          await _httpServices.put("${Constant.userURL}/${user.userId}",
              options: Options(
                headers: {
                  "Authorization": token,
                },
              ),
              data: formData);
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      print(e.toString());
      return 0;
    }
  }

  Future<User> getCurrentUser() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('token');

      Response response = await _httpServices.get(
        Constant.currentUserURL,
        options: Options(
          headers: {
            "Authorization": token,
          },
        ),
      );

      if (response.statusCode == 200) {
        UserResponse userResponse = UserResponse.fromJson(response.data);
        final user = userResponse.data!;

        // Store user ID in shared preferences
        prefs.setString('userId', user.userId!);

        return user;
      } else {
        throw Exception('Failed to load user data');
      }
    } catch (e) {
      throw Exception("Failed to fetch user: $e");
    }
  }

  Future<bool> loginUser(String email, String password) async {
    try {
      Response response = await _httpServices.post(
        Constant.userLoginURL,
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        LoginResponse loginResponse = LoginResponse.fromJson(response.data);
        Constant.token = "Bearer ${loginResponse.token!}";
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', Constant.token);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<int> deleteUser(String userId) async {
    try {
      Response response = await _httpServices.delete(
        "${Constant.userURL}/$userId",
        options: Options(
          headers: {
            "Authorization": Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }
}
