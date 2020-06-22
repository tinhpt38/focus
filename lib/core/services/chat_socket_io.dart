import 'package:focus_app/core/models/message.dart';
import 'package:focus_app/core/models/room.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocketIO {
  static final ChatSocketIO _instance = ChatSocketIO._internal();
  static final IO.Socket socket = IO.io('https://homie-chat.herokuapp.com');
  ChatSocketIO._internal();
  factory ChatSocketIO() {
    socket.connect();
    return _instance;
  }

  listenOnlineList({Function(List<User>) onlineList, User user}) {
    socket.on('connect', (_) {
      print("connected");
      socket.emit("user join", user.toJson());
    });
    socket.on("disconnect", (data) {
      List<dynamic> dataRe = data as List<dynamic>;
      List<User> userOnline = List();
      dataRe.forEach((js) {
        userOnline.add(User.formJson(js));
      });
      onlineList(userOnline);
    });

    socket.on("online list", (data) {
      print("user list");
      // List<String> dataRe = data;
      List<User> userOnline = List();
      data.forEach((js) {
        userOnline.add(User.formJson(js));
      });
      onlineList(userOnline);
    });
  }

  listener(User user,
      {Function(Room) invokeRoom,
      Function(Room) invokeInviteToRoom,
      Function(MessageModel) receivedMessage,
      Function(List<User>) usersOnline}) {
    socket.on('connect', (_) {
      print("connected");
      socket.emit("user join", user.toJson());
    });
    socket.on("online list", (data) {
      List<dynamic> dataRe = data as List<dynamic>;
      List<User> userOnline = List();
      dataRe.forEach((js) {
        userOnline.add(User.formJson(js));
      });
      usersOnline(userOnline);
    });
    socket.on("created room", (data) {
      invokeRoom(Room(
          id: data['_id'],
          members: data['members'],
          owner: data['owner'],
          name: data['name']));
    });

    socket.on("invite to room", (data) {
      Room room = Room(
          id: data['_id'],
          members: data['members'],
          owner: data['owner'],
          name: data['name']);
      acceptInviteIntoRoom(room.id);
      if (room.members.contains(user.id)) {
        invokeInviteToRoom(room);
      }
    });

    socket.on("received message", (data) {
      MessageModel msg = MessageModel(
          type: data["type"],
          idSender: data["sender"],
          content: data["content"],
          roomId: data["room"]);
      print("ON received message ${msg.content}");
      receivedMessage(msg);
    });
  }

  createRoom({String ownerId, List<String> memberIds, String name}) {
    socket.emit("create room", {
      'owner': ownerId,
      'members': memberIds,
      'name': name,
    });
    // return this;
  }

  acceptInviteIntoRoom(String id) {
    print("join room $id");
    socket.emit("join room", id);
    // return this;
  }

  chat(String roomid, String sender, dynamic content, String type) {
    print("socket live: ${socket != null}");
    socket.emit("chat message",
        {'room': roomid, 'sender': sender, 'content': content, 'type': type});
    print("socket emit chat message  $content");
  }

  chatAll(String content) {
    socket.emit("chat all", {'content': content});
  }
}
