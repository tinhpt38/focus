import 'package:focus_app/core/api/api.dart';
import 'package:focus_app/core/models/message.dart';
import 'package:focus_app/core/models/room.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/ui/base/base_page_model.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';

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
  SocketIO _socketIO;

  HomeModel({User user}) {
    _user = user;
  }

  setRooms(List<Room> value) {
    _rooms = value;
    notifyListeners();
  }

    setUserOnline(List<User> value) {
    _userOnline = value;
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
    messages
        .add(MessageModel(type: type, content: content, idSender: _user.id));
      _socketIO.sendMessage("addmessage", {});
    notifyListeners();
  }

  createRoomWithUser(String id) async {}


  getUserOnline() async {
    await Api().getUserOnline(
      onSuccess: setUserOnline,
      onError: (msg){

      }
    );
  }

  connectAllRooms() async {}

  connectToRoom(Room room) {
    if(_socketIO != null){
       _socketIO.disconnect();
    }
    _socketIO = SocketIOManager().createSocketIO("domain", "/chat",
        query: "roomid=${room.id}", socketStatusCallback: _socketStatus);
    _socketIO.init();
    _socketIO.subscribe("socket_info", _onSocketInfo);
    _socketIO.connect();
  }


  _onSocketInfo(dynamic data) {
    print("Socket info: " + data);
  }

  _socketStatus(dynamic data) {
    print("Socket status: " + data);
  }
}
