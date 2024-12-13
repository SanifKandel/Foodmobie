// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReminderResponse _$ReminderResponseFromJson(Map<String, dynamic> json) =>
    ReminderResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Reminder.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ReminderResponseToJson(ReminderResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
