import 'package:flutter/material.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/ui/modules/home/home_model.dart';
import 'package:focus_app/ui/modules/home/widgets/search_user/user_item.dart';

class CreateRoomDialog extends StatefulWidget {
  final HomeModel model;

  CreateRoomDialog(this.model);

  @override
  _CreateRoomDialogState createState() => _CreateRoomDialogState();
}

class _CreateRoomDialogState extends State<CreateRoomDialog> {
  HomeModel model;
  
  List<User> searchResult = List();

  @override
  void initState() {
    model = widget.model;
    super.initState();
  }


    searchUser(String text) {
    List<User> values = List();
    model.userOnlineOrigin.forEach((e) {
      if (e.fullName.toLowerCase().contains(text.toLowerCase())) {
        if (e.id != model.user.id) {
          values.add(e);
        }
      }
    });
    setState(() {
      searchResult = values;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
        child: Container(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("Create room"),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("Room name"),
          ),
          Container(
            child: TextFormField(
              onChanged: (text) {
                searchUser(text);
              },
              decoration: InputDecoration(hintText: "Type name of room"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("Add members"),
          ),
          Container(
            child: TextField(
              decoration: InputDecoration(hintText: "Type name of member"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Text("Menber Online"),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: ListView.builder(
                itemCount: model.userOnline.length,
                itemBuilder: (context, index) {
                  return UserItem(
                    userName: model.userOnline[index].fullName,
                    onAddClick: () async {
                      await model
                          .createRoomWithUser(model.userOnline[index].id);
                    },
                  );
                }),
          ))
        ],
      ),
    ));
  }
}
