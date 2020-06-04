import 'package:focus_app/core/models/message.dart';
import 'package:focus_app/core/models/room.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/ui/base/base_page_model.dart';
class HomeModel extends PageModel {
  User _user;
  User get user => _user;

  List<Room> _rooms = [
    Room(),
  ];
  int _indexSelected = 0;
  int get indexSelected => _indexSelected;
  List<Room> get rooms => _rooms;
  List<MessageModel> messages = List();
  List<User> _userOnline = List();
  List<User> get userOnline => _userOnline;

  HomeModel({User user}) {
    _user = user;
  }

  setRooms(List<Room> value) {
    _rooms = value;
    notifyListeners();
  }

  getMessageForUser(int index) async {
    _indexSelected = index;
    notifyListeners();
  }

  searchUser(String text) {
    List<User> values = List();
    _userOnline.forEach((e) {
      if (e.fullName.toLowerCase().contains(text.toLowerCase())) {
        values.add(e);
      }
    });
    _userOnline = values;
    notifyListeners();
  }

  addMessage({MessageType type, dynamic content}) {
    messages.add(MessageModel(
        type: type, content: content, idSender: _user.id));
    notifyListeners();
  }

  createRoomWithUser(String id)async{

  }

  getUserOnline()async{

  }

  connectAllRooms()async{

  }
}
