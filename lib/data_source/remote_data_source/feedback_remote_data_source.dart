import 'dart:io';

import 'package:dio/dio.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/helper/http_service.dart';
import 'package:foodreminder/model/userfeedbacks.dart';
import 'package:mime/mime.dart';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

class FeedbackRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<int> createFeedback(File? file, UserFeedback feedback) async {
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
        'subject': feedback.subject,
        'message': feedback.message,
        'image': image,
      });
      Response response = await _httpServices.post(
        Constant.feedbacksURL,
        options: Options(
          headers: {
            "Authorization": Constant.token,
          },
        ),
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
}
