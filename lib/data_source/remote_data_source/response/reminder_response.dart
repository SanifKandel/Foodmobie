import 'package:foodreminder/model/reminder.dart';
import 'package:json_annotation/json_annotation.dart';
part 'reminder_response.g.dart';

@JsonSerializable()
class ReminderResponse {
  bool? success;
  String? message;
  List<Reminder>? data;

  ReminderResponse({this.success, this.message, this.data});

  factory ReminderResponse.fromJson(Map<String, dynamic> json) =>
      _$ReminderResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ReminderResponseToJson(this);
}
