
import 'package:focus_app/core/models/room.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocketIO {
  static ChatSocketIO _instance = ChatSocketIO._internal();
  ChatSocketIO._internal();
  factory ChatSocketIO() => _instance;

  IO.Socket socket;

  listener(User user, {Function(Room) invokeRoom,
  Function(Room) invokeInviteToRoom}) {
    socket = IO.io('https://homie-chat.herokuapp.com');
    socket.on('connect', (_) {
      print('connect');
      socket.emit("user join", user.toJson());
    });
    socket.on("user online", (data) {
      print("user online: $data");
    });
    socket.on("created room", (data) {
      invokeRoom(Room(
        id: data['_id'],
        members: data['members'],
        owner: data['owner'],
        name: data['name']));
    });
    socket.on("invite to room", (data) {
       invokeInviteToRoom(Room(
        id: data['_id'],
        members: data['members'],
        owner: data['owner'],
        name: data['name']));
    });

    return this;
  }

  createRoom({String ownerId, List<String> memberIds, String name}) {
    socket.emit("create room", {
      'owner': ownerId,
      'members': memberIds,
      'name': name,
    });
    return this;
  }
  acceptInviteIntoRoom(String id){
    socket.emit("join room",id);
  }

  chat(String roomid, String sender, dynamic content, String type){
    socket.emit("chat message",{
      'room':roomid,
      'sender':sender,
      'content':content,
      'type':type
    });
  }
}
