// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      email: json['email'] as String?,
      password: json['password'] as String?,
      userId: json['_id'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      userName: json['userName'] as String?,
      image: json['image'] as String?,
      uId: json['uId'] as int? ?? 0,
    )..foods = (json['food'] as List<dynamic>?)
        ?.map((e) => Food.fromJson(e as Map<String, dynamic>))
        .toList();

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'uId': instance.uId,
      '_id': instance.userId,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'userName': instance.userName,
      'image': instance.image,
      'password': instance.password,
      'food': instance.foods,
    };
