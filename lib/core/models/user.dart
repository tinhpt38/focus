import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class User{
  @JsonKey(name: 'username')
  final String userName;
  @JsonKey(name: 'fullName')
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
  @JsonKey(name:'_id')
  final String id;
  @JsonKey(name: 'rooms')
  final List<String> rooms;


  User({this.userName, this.fullName, this.email, this.password, this.address, this.phone, this.website, this.id, this.rooms});


  factory User.formJson(Map<String, dynamic> json) => _$UserFromJson(json);
  
  toJson() => _$UserToJson(this);





}