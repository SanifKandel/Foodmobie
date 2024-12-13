// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Food _$FoodFromJson(Map<String, dynamic> json) => Food(
      json['name'] as String,
      json['meal'] as String,
      json['calories'] as String,
      json['recipe'] as String,
      json['_id'] as String,
      json['image'] as String,
      json['ingredients'] as String,
      json['time'] as String,
      id: json['id'] as int? ?? 0,
    );

Map<String, dynamic> _$FoodToJson(Food instance) => <String, dynamic>{
      'id': instance.id,
      '_id': instance.foodId,
      'name': instance.name,
      'meal': instance.meal,
      'recipe': instance.recipe,
      'image': instance.image,
      'calories': instance.calories,
      'ingredients': instance.ingredients,
      'time': instance.time,
    };
