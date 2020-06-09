import 'package:focus_app/core/api/api.dart';
import 'package:focus_app/core/models/message.dart';
import 'package:focus_app/core/models/room.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/core/services/chat_socket_io.dart';
import 'package:focus_app/ui/base/base_page_model.dart';

class HomeModel extends PageModel {
  User _user;
  User get user => _user;

  List<Room> _rooms = [
    Room(id: "", name: "Homie Server", members: [], owner: "")
  ];
  int _indexSelected = 0;
  int get indexSelected => _indexSelected;
  List<Room> get rooms => _rooms;
  List<User> _userOnline = List();
  List<User> get userOnlineOrigin => _userOnline;
  List<User> _userOnlineTemp = List();
  List<User> get userOnline => _userOnlineTemp;
  List<User> _memberInListAdd = List();
  List<User> get memberInListAdd => _memberInListAdd;
  ChatSocketIO _chatSocketIO;
  Map<String, List<MessageModel>> _messageAllRoom = {};
  List<MessageModel> _messageForRoom = List();
  List<MessageModel> get messageForRoom => _messageForRoom;
  bool _isLoadingMessage = false;
  bool get isLoadingMessage => _isLoadingMessage;

  HomeModel({User user}) {
    _user = user;
    _chatSocketIO = ChatSocketIO();
  }

  //begin socket
  listenner() {
    _chatSocketIO.listener(_user,
        invokeRoom: addRooms,
        invokeInviteToRoom: inviteToRoom, receivedMessage: (msg) {
      print("recived Message home model call back");
      receivedMessage(msg);
    });
  }

  inviteToRoom(Room room) {
    if (_rooms.indexWhere((r) => r.id == room.id) == null) {
      print("add to room");
      _chatSocketIO.acceptInviteIntoRoom(room.id);
      addRooms(room);
    }
    notifyListeners();
  }

  receivedMessage(MessageModel value) {
    _messageAllRoom[value.roomId].add(value);
    _messageForRoom = _messageAllRoom[value.roomId];
    notifyListeners();
  }

  _generateRoomName() {
    return _memberInListAdd.length == 1
        ? _memberInListAdd.first.fullName
        : _memberInListAdd.first.fullName + "+ And orthers!";
  }

  createRoom(String name) {
    List<String> memberids = List();
    _memberInListAdd.forEach((e) {
      memberids.add(e.id);
    });
    String roomName = name.isEmpty ? _generateRoomName() : name;
    _chatSocketIO.createRoom(
        name: roomName, memberIds: memberids, ownerId: user.id);
  }

  addMessage({dynamic type, dynamic content}) {
    _chatSocketIO.chat(_rooms[_indexSelected].id, user.id, content, type);
    notifyListeners();
  }
  //end socket

  // normal

  setLoadingMessage(bool value) {
    _isLoadingMessage = value;
    notifyListeners();
  }

  addRooms(Room value) {
    _rooms.add(value);
    notifyListeners();
  }

  removeRooms(Room value) {
    _rooms.remove(value);
    notifyListeners();
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

  clearMemberAddToRoom() {
    _userOnlineTemp.addAll(_memberInListAdd);
    _memberInListAdd.clear();
  }

  setUserOnline(List<User> value) {
    _userOnline = value;
    notifyListeners();
  }

  changeIndexSelected(int index) async {
    _indexSelected = index;
    String roomID = _rooms[index].id;
    if (_messageAllRoom[roomID] == null) {
      await getAllMessageForRoom();
    }
    _messageForRoom = _messageAllRoom[roomID];
    notifyListeners();
  }

  setRoom(List<Room> values) {
    _rooms = values;
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

  getUserOnline() async {
    await Api().getUserOnline(onSuccess: setUserOnline, onError: (msg) {});
  }

  getRoomOfUserId() async {
    await Api().getRoomOfUserID(
        id: user.id,
        onSuccess: (rooms) async {
          setRoom(rooms);
          await getAllMessageForRoom();
          _messageForRoom = _messageAllRoom[rooms[_indexSelected].id];
          notifyListeners();
        },
        onError: (msg) {});
  }

  getAllMessageForRoom() async {
    setLoadingMessage(true);
    String roomID = _rooms[_indexSelected].id;
    await Api().getMessageForRoom(
        roomId: roomID,
        onSuccess: (values) {
          updateMessageAllRoom(values, roomID);
        });
    _messageForRoom = _messageAllRoom[roomID];
    setLoadingMessage(false);
  }

  updateMessageAllRoom(List<MessageModel> values, String roomID) {
    _messageAllRoom[roomID] = values;
    notifyListeners();
  }
}
