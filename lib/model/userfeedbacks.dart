import 'package:json_annotation/json_annotation.dart';
import 'package:objectbox/objectbox.dart';
part 'userfeedbacks.g.dart';

// flutter pub run build_runner build --delete-conflicting-outputs

@Entity()
@JsonSerializable()
class UserFeedback {
  @Id(assignable: true)
  int fId;
  @Unique()
  @Index()
  @JsonKey(name: '_id')
  String? feedbackId;
  String? subject;
  String? message;

  UserFeedback(
      {this.subject,
      this.message,
      this.feedbackId,
  
      this.fId = 0});
  factory UserFeedback.fromJson(Map<String, dynamic> json) => _$UserFeedbackFromJson(json);
  Map<String, dynamic> toJson() => _$UserFeedbackToJson(this);
}
