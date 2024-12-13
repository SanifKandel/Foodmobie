import 'package:foodreminder/model/notification.dart';
import 'package:json_annotation/json_annotation.dart';
part 'notification_response.g.dart';

@JsonSerializable()
class NotificationResponse {
  bool? success;
  String? message;
  List<FoodMobieNotification>? data;

  NotificationResponse({this.success, this.message, this.data});

  factory NotificationResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationResponseFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationResponseToJson(this);
}
