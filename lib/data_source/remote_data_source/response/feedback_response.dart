import 'package:foodreminder/model/userfeedbacks.dart';
import 'package:json_annotation/json_annotation.dart';
part 'feedback_response.g.dart';

@JsonSerializable()
class FeedbackResponse {
  bool? success;
  String? message;
  List<UserFeedback>? data;

  FeedbackResponse({this.success, this.message, this.data});

  factory FeedbackResponse.fromJson(Map<String, dynamic> json) =>
      _$FeedbackResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FeedbackResponseToJson(this);
}
