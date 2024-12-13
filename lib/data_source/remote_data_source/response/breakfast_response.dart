import 'package:foodreminder/model/recommendation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'breakfast_response.g.dart';

@JsonSerializable()
class BreakfastResponse {
  bool? success;
  String? message;
  List<Recommend>? breakfast;

  BreakfastResponse({this.success, this.message, this.breakfast});

  factory BreakfastResponse.fromJson(Map<String, dynamic> json) =>
      _$BreakfastResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BreakfastResponseToJson(this);
}
