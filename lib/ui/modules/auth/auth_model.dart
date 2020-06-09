import 'package:focus_app/core/api/api.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/ui/base/base_page_model.dart';
import 'package:focus_app/ui/base/share_key.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthModel extends PageModel {
  User _user;
  User get user => _user;
  Api _api = Api();
  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  String _token = "";
  bool _loginSuccess = false;
  bool get success => _loginSuccess;

  setLoginSuccess(bool value){
    _loginSuccess = value;
    notifyListeners();
  }
  
  setUser(User value){
    _user = value;
    notifyListeners();
  }

  setError(String message){
    _errorMessage = message;
    _loginSuccess = false;
    notifyListeners();
  }


  login(String username, String password) async {
    setBusy(true);
    await _api.login(user: username, password: password,
    onError: (err){
      setError(err);
    },
    onSuccess: (user,token)async{
      _token = token;
      setUser(user);
      setLoginSuccess(true);
      SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(ShareKey.token, _token);
    preferences.setString(ShareKey.uid, user.id);
    });
    setBusy(false);
  }

  register(User user) async {
    setBusy(true);
    await _api.register(user: user,
    onError: setError,
    onSuccess: (user,token){
      _token = token;
      setUser(user);
      setLoginSuccess(true);
    });
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString(ShareKey.token, _token);
    setBusy(false);
  }

}
