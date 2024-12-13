// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'breakfast_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BreakfastResponse _$BreakfastResponseFromJson(Map<String, dynamic> json) =>
    BreakfastResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      breakfast: (json['breakfast'] as List<dynamic>?)
          ?.map((e) => Recommend.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BreakfastResponseToJson(BreakfastResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'breakfast': instance.breakfast,
    };
