

import 'dart:async';

class LoginBloc{
  StreamController _emailCheck = StreamController();
  Stream get emailInvalidate => _emailCheck.stream;

}