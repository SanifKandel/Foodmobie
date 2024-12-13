import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'food.g.dart';

@Entity()
@JsonSerializable()
class Food {
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

  // @Backlink()
  // final user = ToMany<User>();
  Food(this.name, this.meal, this.calories, this.recipe, this.foodId,
      this.image, this.ingredients, this.time,
      {this.id = 0});

  factory Food.fromJson(Map<String, dynamic> json) => _$FoodFromJson(json);
  Map<String, dynamic> toJson() => _$FoodToJson(this);
}
