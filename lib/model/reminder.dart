import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'reminder.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

@Entity()
@JsonSerializable()
class Reminder {
  @Id(assignable: true)
  int rId;
  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? reminderId;
  String? foodname;
  String? calories;
  String? cookingtime;
  String? meal;
  String? date;
  String? time;
  String? recipe;
  String? ingredients;
  String? message;

  Reminder(
      {this.foodname,
      this.calories,
      this.cookingtime,
      this.meal,
      this.recipe,
      this.ingredients,
      this.message,
      this.time,
      this.date,
      this.reminderId,
      this.rId = 0});
  factory Reminder.fromJson(Map<String, dynamic> json) =>
      _$ReminderFromJson(json);
  Map<String, dynamic> toJson() => _$ReminderToJson(this);
}
