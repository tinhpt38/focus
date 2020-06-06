import 'package:focus_app/core/api/api.dart';
import 'package:focus_app/core/models/message.dart';
import 'package:focus_app/core/models/room.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/core/services/chat_socket.dart';
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
  List<User> get userOnlineOrigin => _userOnline;
  List<User> _userOnlineTemp = List();
  List<User> get userOnline => _userOnlineTemp;
  ChatSocket _chatSocket = ChatSocket();
  List<User> _memberInListAdd = List();
  List<User> get memberInListAdd => _memberInListAdd;

  HomeModel({User user}) {
    _user = user;
    _chatSocket.connect();
  }

  addMemberInList(User value) {
    _memberInListAdd.add(value);
    _userOnlineTemp.remove(value);
    notifyListeners();
  }

  removeMemberInList(User value) {
    _memberInListAdd.remove(value);
    _userOnlineTemp.add(value);
    notifyListeners();
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
    connectToRoom(_rooms[index]);
    notifyListeners();
  }

  searchUser(String text) {
    List<User> values = List();
    _userOnline.forEach((e) {
      if (e.fullName.toLowerCase().contains(text.toLowerCase())) {
        if (e.id != user.id) {
          values.add(e);
        }
      }
    });
    _userOnlineTemp = values;
    notifyListeners();
  }

  addMessage({MessageType type, dynamic content}) {
    messages
        .add(MessageModel(type: type, content: content, idSender: _user.id));
    // _socketIO.sendMessage("addmessage", {});
    notifyListeners();
  }

  createRoomWithUser(String id) async {}

  getUserOnline() async {
    await Api().getUserOnline(onSuccess: setUserOnline, onError: (msg) {});
  }

  connectAllRooms() async {}

  connectToRoom(Room room) {
    // _chatSocket.listenner(
    //     room: room, subscribe: (message) {}, socketStatus: (status) {});
  }

  getRoomOfUserId() async {
    await Api()
        .getRoomOfUserID(id: user.id, onSuccess: (rooms) {}, onError: (msg) {});
  }

  createRoom(String name){
    List<String> memberids = List();
    _memberInListAdd.forEach((e) {
      memberids.add(e.id);
     });
    _chatSocket.createRoom(
      name: name,
      memberIds: memberids,
      ownerId: user.id,
      onSuccess: (room){
        print("create room success");
      }
    );
  }


  
}
