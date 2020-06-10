import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:focus_app/core/api/api.dart';
import 'package:focus_app/core/models/room.dart';
import 'package:flutter_socket_io/socket_io_manager.dart';
import 'package:flutter_socket_io/flutter_socket_io.dart';
import 'package:focus_app/core/models/user.dart';


class ChatSocket {
  SocketIO _socketIO;

  static ChatSocket _instance = ChatSocket._internal();

  ChatSocket._internal();

  factory ChatSocket() => _instance;

  connect(User user){
    _socketIO = SocketIOManager().createSocketIO(endpoint, "",
        socketStatusCallback: (status) {
      print("socket status: $status");
    });
    _socketIO.init();
    _socketIO.connect();
    if(_socketIO.getId() == null){
      print("socket not connected");
    }
    print("socket  connected");
    // _socketIO.sendMessage("user join", json.encode(user.toJson()));
    return this;
  }

  chatRoom({@required Room room, Function(dynamic) subscribe}) {
    _socketIO.subscribe("socket_info", subscribe);
    return this;
  }

  createRoom(
      {String ownerId,
      List<String> memberIds,
      String name,
      Function(Room) onSuccess}) {
    _socketIO.sendMessage("create room", {
      'owner': ownerId,
      'members': json.encode(memberIds),
      'name': name,
    });
    _socketIO.subscribe("created room", (data) {
      onSuccess(Room());
      print('data  $data');
    });
    return this;
  }
}
