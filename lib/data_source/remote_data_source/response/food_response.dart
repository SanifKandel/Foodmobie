import 'package:foodreminder/model/food.dart';
import 'package:json_annotation/json_annotation.dart';
part 'food_response.g.dart';

@JsonSerializable()
class FoodResponse {
  bool? success;
  String? message;
  List<Food>? data;

  FoodResponse({this.success, this.message, this.data});

  factory FoodResponse.fromJson(Map<String, dynamic> json) =>
      _$FoodResponseFromJson(json);

  Map<String, dynamic> toJson() => _$FoodResponseToJson(this);
}
