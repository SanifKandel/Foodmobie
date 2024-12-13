import 'package:dio/dio.dart';
import 'package:foodreminder/app/constants.dart';
import 'package:foodreminder/data_source/remote_data_source/response/notification_response.dart';
import 'package:foodreminder/helper/http_service.dart';
import 'package:foodreminder/model/notification.dart';

class NotificationsRemoteDataSource {
  final Dio _httpServices = HttpServices().getDioInstance();

  Future<List<FoodMobieNotification>> getAllNotifications() async {
    try {
      Response response = await _httpServices.get(
        Constant.notificationURL,
        options: Options(
          headers: {
            "Authorization": Constant.token,
          },
        ),
      );
      if (response.statusCode == 200) {
        NotificationResponse notificationsResponse =
            NotificationResponse.fromJson(response.data);
        return notificationsResponse.data!;
      } else {
        return [];
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
