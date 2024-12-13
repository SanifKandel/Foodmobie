// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodMobieNotification _$FoodMobieNotificationFromJson(
        Map<String, dynamic> json) =>
    FoodMobieNotification(
      json['title'] as String,
      json['description'] as String,
      json['date'] as String,
      json['_id'] as String,
      json['time'] as String,
      json['image'] as String,
      id: json['id'] as int? ?? 0,
    );

Map<String, dynamic> _$FoodMobieNotificationToJson(
        FoodMobieNotification instance) =>
    <String, dynamic>{
      'id': instance.id,
      '_id': instance.notificationId,
      'title': instance.title,
      'description': instance.description,
      'date': instance.date,
      'time': instance.time,
      'image': instance.image,
    };
