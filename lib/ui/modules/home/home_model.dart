import 'package:flutter/material.dart';
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
    Room(
      id: "",
      name: "Homie Server",
      members: [],
      owner: ""
    )
  ];
  int _indexSelected = 0;
  int get indexSelected => _indexSelected;
  List<Room> get rooms => _rooms;
  List<MessageModel> messages = List();
  List<User> _userOnline = List();
  List<User> get userOnlineOrigin => _userOnline;
  List<User> _userOnlineTemp = List();
  List<User> get userOnline => _userOnlineTemp;
  List<User> _memberInListAdd = List();
  List<User> get memberInListAdd => _memberInListAdd;
  ChatSocketIO _chatSocketIO = ChatSocketIO();
  bool _inviteNotification = false;
  bool get inviteNotification => _inviteNotification;
  Room _roomInvite;
  Room get roomInvite => _roomInvite;

  HomeModel({User user}) {
    _user = user;
    // _chatSocket.connect(user);
    _chatSocketIO.listener(user, invokeRoom: addRooms,
    invokeInviteToRoom: inviteToRoom);
  }

  inviteToRoom(Room room){
    _roomInvite = room;
    _inviteNotification = true;
    notifyListeners();
  }

  joinRoomBeInvite(){
    _inviteNotification = false;
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

  acceptInviteIntoRoom(String id){
    _chatSocketIO.acceptInviteIntoRoom(id);
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

  clearMemberAddToRoom(){
    _userOnlineTemp.addAll(_memberInListAdd);
    _memberInListAdd.clear();
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
        if (e.id != user.id) {
          values.add(e);
        }
      }
    });
    _userOnlineTemp = values;
    notifyListeners();
  }

  addMessage({MessageType type, dynamic content}) {
    // messages
    //     .add(MessageModel(type: type, content: content, idSender: _user.id));
    _chatSocketIO.chat(_rooms[_indexSelected].id, user.id,content, "text");
    notifyListeners();
  }

  createRoomWithUser(String id) async {}

  getUserOnline() async {
    await Api().getUserOnline(onSuccess: setUserOnline, onError: (msg) {});
  }

  getRoomOfUserId() async {
    await Api()
        .getRoomOfUserID(id: user.id, onSuccess: (rooms) {}, onError: (msg) {});
  }


  createRoom(String name) {
    List<String> memberids = List();
    _memberInListAdd.forEach((e) {
      memberids.add(e.id);
    });
    print('member id $memberids');
    _chatSocketIO.createRoom(
        name: name, memberIds: memberids, ownerId: user.id);
  }
}
