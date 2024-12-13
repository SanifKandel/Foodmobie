import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'notification.g.dart';

@Entity()
@JsonSerializable()
class FoodMobieNotification {
  @Id(assignable: true)
  int id;

  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String notificationId;
  String title;
  String description;
  String date;
  String time;
  String image;

  FoodMobieNotification(this.title, this.description, this.date, this.notificationId,
      this.time, this.image,
      {this.id = 0});

  factory FoodMobieNotification.fromJson(Map<String, dynamic> json) =>
      _$FoodMobieNotificationFromJson(json);
  Map<String, dynamic> toJson() => _$FoodMobieNotificationToJson(this);
}
