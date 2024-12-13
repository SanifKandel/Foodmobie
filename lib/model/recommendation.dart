import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'recommendation.g.dart';

@Entity()
@JsonSerializable()
class Recommend {
  @Id(assignable: true)
  int id;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String foodId;
  String name;
  String meal;
  String recipe;
  String image;
  String calories;
  String ingredients;
  String time;

  Recommend(this.name, this.meal, this.calories, this.recipe, this.foodId,
      this.image, this.ingredients, this.time,
      {this.id = 0});

  factory Recommend.fromJson(Map<String, dynamic> json) =>
      _$RecommendFromJson(json);
  Map<String, dynamic> toJson() => _$RecommendToJson(this);
}
