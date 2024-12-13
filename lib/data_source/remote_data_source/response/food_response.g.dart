// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FoodResponse _$FoodResponseFromJson(Map<String, dynamic> json) => FoodResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Food.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FoodResponseToJson(FoodResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
    };
