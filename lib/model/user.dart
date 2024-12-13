import 'package:foodreminder/model/food.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'user.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

@Entity()
@JsonSerializable()
class User {
  @Id(assignable: true)
  int uId;
  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? userId;
  String? email;
  String? firstName;
  String? lastName;
  String? userName;
  String? image;
  String? password;
  @JsonKey(name: 'food')
  List<Food>? foods;
  final food = ToMany<Food>();

  User(
      {this.email,
      this.password,
      this.userId,
      this.firstName,
      this.lastName,
      this.userName,
      this.image,
      this.uId = 0});
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
