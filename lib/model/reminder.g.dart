// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Reminder _$ReminderFromJson(Map<String, dynamic> json) => Reminder(
      foodname: json['foodname'] as String?,
      calories: json['calories'] as String?,
      cookingtime: json['cookingtime'] as String?,
      meal: json['meal'] as String?,
      recipe: json['recipe'] as String?,
      ingredients: json['ingredients'] as String?,
      message: json['message'] as String?,
      time: json['time'] as String?,
      date: json['date'] as String?,
      reminderId: json['_id'] as String?,
      rId: json['rId'] as int? ?? 0,
    );

Map<String, dynamic> _$ReminderToJson(Reminder instance) => <String, dynamic>{
      'rId': instance.rId,
      '_id': instance.reminderId,
      'foodname': instance.foodname,
      'calories': instance.calories,
      'cookingtime': instance.cookingtime,
      'meal': instance.meal,
      'date': instance.date,
      'time': instance.time,
      'recipe': instance.recipe,
      'ingredients': instance.ingredients,
      'message': instance.message,
    };
