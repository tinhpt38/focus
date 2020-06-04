import 'package:focus_app/core/models/message.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/ui/base/base_page_model.dart';
import 'package:focus_app/ui/base/common.dart';
class HomeModel extends PageModel {
  User _user;
  User get user => _user;

  List<String> _users = ["Mi", "Hai", "Lam", "Bang", "Ha", "Hanh", "Huy"];
  int _indexSelected = 0;
  int get indexSelected => _indexSelected;
  List<String> get users => _users;
  List<MessageModel> messages = List();
  List<String> _userSearch = List();
  List<String> get userSearch => _userSearch;

  HomeModel({User user}) {
    _user = user;
    messages = [
      MessageModel(
          type: MessageType.text, content: textTest1, idSender: user.id),
      MessageModel(
          type: MessageType.text, content: textTest1, idSender: "as i"),
      MessageModel(
          type: MessageType.text, content: textTest1, idSender: user.id),
      MessageModel(
          type: MessageType.text, content: textTest1, idSender: "as i"),
    ];
  }

  setUsers(List<String> value) {
    _users = value;
    notifyListeners();
  }

  getMessageForUser(int index) async {
    _indexSelected = index;
    notifyListeners();
  }

  searchUser(String text) {
    List<String> values = List();
    _users.forEach((e) {
      if (e.toLowerCase().contains(text.toLowerCase())) {
        values.add(e);
      }
    });
    _userSearch = values;
    notifyListeners();
  }

  addMessage({MessageType type, dynamic content}) {
    messages.add(MessageModel(
        type: type, content: content, idSender: _user.id));
    notifyListeners();
  }
}
