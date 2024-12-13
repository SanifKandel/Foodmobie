// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dinner_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DinnerResponse _$DinnerResponseFromJson(Map<String, dynamic> json) =>
    DinnerResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      dinner: (json['dinner'] as List<dynamic>?)
          ?.map((e) => Recommend.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$DinnerResponseToJson(DinnerResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'dinner': instance.dinner,
    };
