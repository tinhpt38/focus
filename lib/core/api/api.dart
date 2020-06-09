import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focus_app/core/models/message.dart';
import 'package:focus_app/core/models/room.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/ui/base/share_key.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

String endpoint = "https://homie-chat.herokuapp.com";

class Api {

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
      "password": user.password,
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

  Future<Map<String, String>> headerAuthorization() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String token = sharedPreferences.getString(ShareKey.token);
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    };
  }

  Future<void> getUserOnline(
      {Function(List<User>) onSuccess, Function(String) onError}) async {
    String url = '$endpoint/user?limit=10&offset=0';
    var header = await headerAuthorization();
    var res = await http.get(url, headers: header);
    if (res.statusCode == 200) {
      try {
        dynamic jsonRes = json.decode(res.body);
        if (jsonRes['success']) {
          List<dynamic> jsonData = jsonRes['data'];
          List<User> users = List();
          jsonData.forEach((e) {
            users.add(User.formJson(e));
          });
          onSuccess(users);
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

  Future<void> getRoomOfUserID({
    @required String id,
    Function(List<Room>) onSuccess,
    Function(String) onError,
  }) async {
    String url = '$endpoint/rooms?userId=$id&limit=10&offset=0';
    var header = await headerAuthorization();
    var res = await http.get(url, headers: header);
    if (res.statusCode == 200) {
      try {
        dynamic jsonRes = json.decode(res.body);
        if (jsonRes['success']) {
          List<dynamic> jsonData = jsonRes['data'];
          List<Room> rooms = List();
          jsonData.forEach((e) {
            rooms.add(Room.formJson(e));
          });
          onSuccess(rooms);
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
  Future<void> getMessageForRoom({
    @required String roomId,
    Function(List<MessageModel>) onSuccess,
    Function(String) onError,
  }) async {
    String url = '$endpoint/messages?roomId=$roomId&limit=10&offset=0';
    var header = await headerAuthorization();
    var res = await http.get(url, headers: header);
    if (res.statusCode == 200) {
      try {
        dynamic jsonRes = json.decode(res.body);
        if (jsonRes['success']) {
          List<dynamic> jsonData = jsonRes['data'];
          List<MessageModel> messages = List();
          jsonData.forEach((e) {
            messages.add(MessageModel.formJson(e));
          });
          onSuccess(messages);
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
