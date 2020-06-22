import 'package:focus_app/core/api/api.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/core/services/chat_socket_io.dart';
import 'package:focus_app/ui/modules/home/home_model.dart';

class AdminModel extends HomeModel {
  ChatSocketIO _chatSocketIO = ChatSocketIO();
  User _user;
  User get user => _user;
  bool _isLogout = false;
  bool get isLogout => _isLogout;
  bool _isLogouting = false;
  bool get isLogginOut => _isLogouting;

  List<User> _userOnline = List();
  List<User> get userOnlineList => _userOnline;

  AdminModel({User user}) {
    this._user = user;
  }

  listenner() {
    _chatSocketIO.listenOnlineList(
        user: _user,
        onlineList: (values) {
          setUser(values);
        });
  }

  setUser(List<User> values) {
    _userOnline = values;
    notifyListeners();
  }

    setLogout(bool value) {
    _isLogout = value;
    notifyListeners();
  }

    setLogingOut(bool value) {
    _isLogouting = value;
    notifyListeners();
  }

}
