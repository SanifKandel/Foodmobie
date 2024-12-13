// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userfeedbacks.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserFeedback _$UserFeedbackFromJson(Map<String, dynamic> json) => UserFeedback(
      subject: json['subject'] as String?,
      message: json['message'] as String?,
      feedbackId: json['_id'] as String?,
      fId: json['fId'] as int? ?? 0,
    );

Map<String, dynamic> _$UserFeedbackToJson(UserFeedback instance) =>
    <String, dynamic>{
      'fId': instance.fId,
      '_id': instance.feedbackId,
      'subject': instance.subject,
      'message': instance.message,
    };
