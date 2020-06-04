// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      userName: json['user_name'] as String,
      fullName: json['full_name'] as String,
      email: json['email'] as String,
      password: json['password'] as String,
      address: json['address'] as String,
      phone: json['phone'] as String,
      website: json['website'] as String,
      id: json['_id'] as String,
      rooms: json['rooms'] as List<String>);
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_name': instance.userName,
      'full_name': instance.fullName,
      'email': instance.email,
      'password': instance.password,
      'address': instance.address,
      'phone': instance.phone,
      'website': instance.website,
      '_id': instance.id,
      'rooms': instance.rooms
    };
