import 'package:foodreminder/model/recommendation.dart';
import 'package:json_annotation/json_annotation.dart';
part 'dinner_response.g.dart';

@JsonSerializable()
class DinnerResponse {
  bool? success;
  String? message;
  List<Recommend>? dinner;

  DinnerResponse({this.success, this.message, this.dinner});

  factory DinnerResponse.fromJson(Map<String, dynamic> json) =>
      _$DinnerResponseFromJson(json);

  Map<String, dynamic> toJson() => _$DinnerResponseToJson(this);
}
