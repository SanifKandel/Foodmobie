// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lunch_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LunchResponse _$LunchResponseFromJson(Map<String, dynamic> json) =>
    LunchResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      lunch: (json['lunch'] as List<dynamic>?)
          ?.map((e) => Recommend.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$LunchResponseToJson(LunchResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'lunch': instance.lunch,
    };
