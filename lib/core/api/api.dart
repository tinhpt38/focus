import 'dart:convert';

import 'package:focus_app/core/models/user.dart';
import 'package:http/http.dart' as http;

class Api {
  String endpoint = "https://homie-chat.herokuapp.com";

  Future<void> login({
    String user,
    String password,
    Function(User, String) onSuccess,
    Function(String) onError,
  }) async {
    var url = "$endpoint/auth/login";
    Map<String, String> body = {'username': user, 'password': password};
    var res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      try {
        dynamic jsonRes = json.decode(res.body);
        if (jsonRes['success']) {
          dynamic jsonData = jsonRes['data'];
          User user = User.formJson(jsonData['user']);
          String token = jsonData['token'];
          onSuccess(user, token);
          print("token $token");
          return;
        } else {
          onError(jsonRes['message']);
        }
      } catch (e) {
        onError('Something get wrong! try again.');
      }
    } else {
      onError('Something get wrong! try again.');
    }
  }

  Future<void> register(
      {User user,
      Function(User, String) onSuccess,
      Function(String) onError}) async {
    String url = '$endpoint/auth/signup';
    Map<String, dynamic> body = {
      "username": user.userName,
      "fullName": user.fullName,
      "password":  user.password,
      "confirmPassword": user.password
    };
    var res = await http.post(url, body: body);
    if (res.statusCode == 200) {
      try {
        dynamic jsonRes = json.decode(res.body);
        if (jsonRes['success']) {
          dynamic jsonData = jsonRes['data'];
          User user = User.formJson(jsonData['user']);
          String token = jsonData['token'];
          onSuccess(user, token);
          print("token $token");
          return;
        } else {
          onError(jsonRes['message']);
        }
      } catch (e) {
        onError('Something get wrong! try again.');
      }
    } else if (res.statusCode == 400) {
      dynamic jsonRes = json.decode(res.body);
      onError(jsonRes['message']);
    } else {
      onError('Something get wrong! try again.');
    }
  }
}
