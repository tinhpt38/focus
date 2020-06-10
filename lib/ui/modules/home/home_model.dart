import 'package:focus_app/core/api/api.dart';
import 'package:focus_app/core/models/message.dart';
import 'package:focus_app/core/models/room.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/core/services/chat_socket_io.dart';
import 'package:focus_app/ui/base/base_page_model.dart';

class HomeModel extends PageModel {
  User _user;
  User get user => _user;

  List<Room> _rooms = List();
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
  bool _isLogouting = false;
  bool get isLogginOut => _isLogouting;
  bool _isLogout = false;
  bool get isLogout => _isLogout;
  int _limit = 10;
  int _totalOnline = 0;
  int get totalOnline => _totalOnline;

  HomeModel({User user}) {
    _user = user;
    _chatSocketIO = ChatSocketIO();
  }

  //begin socket
  listenner() {
    _chatSocketIO.listener(_user,
        invokeRoom: addRooms,
        invokeInviteToRoom: inviteToRoom,
        receivedMessage: (msg) {
      print("recived Message home model call back");
      receivedMessage(msg);
    },
    usersOnline: (uOnlines){
      setTotalOnline(uOnlines.length);
    }
    );
  }

  inviteToRoom(Room room) {
    bool isHaveRoom = false;
    _rooms.forEach((r) {
      if (r.id as String == room.id as String) {
        isHaveRoom = true;
      }
    });
    if (!isHaveRoom) {
      print("add to room");
      addRooms(room);
    }
    notifyListeners();
  }

  receivedMessage(MessageModel value) {
    _messageAllRoom[value.roomId].add(value);
    Room currentRoom = _rooms[_indexSelected];
    if (currentRoom.id == value.roomId) {
      _messageForRoom = _messageAllRoom[value.roomId];
    }
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
    memberids.add(user.id);
    String roomName = name.isEmpty ? _generateRoomName() : name;
    _chatSocketIO.createRoom(
        name: roomName, memberIds: memberids, ownerId: user.id);
  }

  addMessage({dynamic type, dynamic content}) {
    Room room = _rooms[_indexSelected];
    MessageModel messageModel = MessageModel(
        roomId: room.id, idSender: user.id, content: content, type: type);
    _messageAllRoom[room.id].add(messageModel);
    // _messageForRoom.add(messageModel);
    _chatSocketIO.chat(_rooms[_indexSelected].id, user.id, content, type);
    notifyListeners();
  }
  //end socket

  // normal

  setTotalOnline(int value){
    _totalOnline = value;
    notifyListeners();
  }

  setLogout(bool value) {
    _isLogout = value;
    notifyListeners();
  }

  setLoadingMessage(bool value) {
    _isLoadingMessage = value;
    notifyListeners();
  }

  setLogingOut(bool value) {
    _isLogouting = value;
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

  getUserOnline({int limit = 10}) async {
    await Api().getUserOnline(onSuccess: setUserOnline, onError: (msg) {});
  }

  autoJoinRoom(){
    _rooms.forEach((e) {
      _chatSocketIO.acceptInviteIntoRoom(e.id);
     });
  }

  getRoomOfUserId({int limit = 10}) async {
    await Api().getRoomOfUserID(
        limit: limit,
        id: user.id,
        onSuccess: (rooms) async {
          setBusy(false);
          setRoom(rooms);
          await getAllMessageForRoom();
          _messageForRoom = _messageAllRoom[rooms[_indexSelected].id];
          notifyListeners();
        },
        onError: (msg) {});
  }

  getAllMessageForRoom({int limit = 10}) async {
    setLoadingMessage(true);
    String roomID = _rooms[_indexSelected].id;
    await Api().getMessageForRoom(
        limit: limit,
        roomId: roomID,
        onSuccess: (values) {
          updateMessageAllRoom(values, roomID);
          setLoadingMessage(false);
        });
    _messageForRoom = _messageAllRoom[roomID];
    notifyListeners();
    setLoadingMessage(false);
  }

  loadmoreMessageForRoom() async {
    await getAllMessageForRoom(limit: _limit + _messageForRoom.length);
  }

  loadmoreRooms() async {
    await getRoomOfUserId(limit: _limit + _rooms.length);
  }

  loadmoreUserOnline() async {
    await getUserOnline(limit: _limit + _userOnline.length);
  }

  updateMessageAllRoom(List<MessageModel> values, String roomID) {
    _messageAllRoom[roomID] = values;
    notifyListeners();
  }

  logout() async {
    setLogingOut(true);
    await Api().logout(onSuccess: () {
      setLogout(true);
      return;
    }, onError: (msg) {
      setLogout(false);
      return;
    });
    setLogingOut(false);
  }
}
