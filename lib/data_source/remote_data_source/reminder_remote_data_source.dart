import 'dart:io';

import 'package:dio/dio.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/data_source/remote_data_source/response/reminder_response.dart';
import 'package:foodreminder/helper/http_service.dart';
import 'package:foodreminder/model/reminder.dart';
import 'package:mime/mime.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class RemindersRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> createReminder(File? file, Reminder reminder) async {
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
      // FormData formData = FormData.fromMap({

      //   // 'image': image,
      // });
      Response response = await _httpServices.post(
        Constant.reminderURL,
        options: Options(
          headers: {
            "Authorization": Constant.token,
          },
        ),
        data: {
          'foodname': reminder.foodname,
          'cookingtime': reminder.cookingtime,
          'calories': reminder.calories,
          'meal': reminder.meal,
          'date': reminder.date,
          'time': reminder.time,
          'recipe': reminder.recipe,
          'ingredients': reminder.ingredients,
          'message': reminder.message,
        },
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

  Future<List<Reminder>> getAllReminder() async {
    try {
      Response response = await _httpServices.get(
        Constant.reminderURL,
        options: Options(
          headers: {
            "Authorization": Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        ReminderResponse remindersResponse =
            ReminderResponse.fromJson(response.data);
        return remindersResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<int> updateReminder(File? file, Reminder reminder) async {
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

      final formData = FormData.fromMap({
        'foodname': reminder.foodname,
        'calories': reminder.calories,
        'date': reminder.date,
        'meal': reminder.meal,
        'time': reminder.time,
        'cookingtime': reminder.cookingtime,
        'recipe': reminder.recipe,
        'ingredients': reminder.ingredients,
        'message': reminder.message,
      });
      Response response = await _httpServices
          .put("${Constant.reminderURL}/${reminder.reminderId}",
              options: Options(
                headers: {
                  "Authorization": Constant.token,
                },
              ),
              data: {
            'foodname': reminder.foodname,
            'calories': reminder.calories,
            'date': reminder.date,
            'meal': reminder.meal,
            'time': reminder.time,
            'cookingtime': reminder.cookingtime,
            'recipe': reminder.recipe,
            'ingredients': reminder.ingredients,
            'message': reminder.message,
          });
      if (response.statusCode == 200) {
        return 1;
      } else {
        return 0;
      }
    } catch (e) {
      return 0;
    }
  }

  Future<int> deleteReminder(String reminderId) async {
    try {
      Response response = await _httpServices.delete(
        "${Constant.reminderURL}/$reminderId",
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
