import 'package:foodreminder/model/recommendation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'lunch_response.g.dart';

@JsonSerializable()
class LunchResponse {
  bool? success;
  String? message;
  List<Recommend>? lunch;

  LunchResponse({this.success, this.message, this.lunch});

  factory LunchResponse.fromJson(Map<String, dynamic> json) =>
      _$LunchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LunchResponseToJson(this);
}
