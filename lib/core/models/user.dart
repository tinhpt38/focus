import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User{
  @JsonKey(name: 'user_name')
  final String userName;
  @JsonKey(name: 'full_name')
  final String fullName;
  @JsonKey(name: 'email')
  final String email;
  @JsonKey(name: 'password')
  final String password;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'phone')
  final String phone;
  @JsonKey(name: 'website')
  final String website;

  User({this.userName, this.fullName, this.email, this.password, this.address, this.phone, this.website});


  factory User.formJson(Map<String, dynamic> json) => _$UserFromJson(json);
  
  toJson() => _$UserToJson(this);





}