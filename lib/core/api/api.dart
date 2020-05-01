import 'dart:convert';

import 'package:focus_app/core/models/user.dart';
import 'package:http/http.dart' as http;

class Api {
  Future<void> login({
    String user,
    String password,
    Function(User, String) onSuccess,
    Function(String) onError,
  }) async {
    var endpoint = "https://homie-chat.herokuapp.com/auth/login";
    Map<String, String> body = {'username': user, 'password': password};
    var res = await http.post(endpoint, body: body);
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
}
