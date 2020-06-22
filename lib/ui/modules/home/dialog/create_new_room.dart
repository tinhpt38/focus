import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/app_color.dart';
import 'package:focus_app/ui/modules/home/home_model.dart';
import 'package:focus_app/ui/modules/home/widgets/search_user/select_item.dart';
import 'package:focus_app/ui/modules/home/widgets/search_user/user_item.dart';

class CreateNewRoom extends StatefulWidget {

  final HomeModel model;

  CreateNewRoom(this.model);
  @override
  _CreateNewRomState createState() => _CreateNewRomState();
}

class _CreateNewRomState extends State<CreateNewRoom> {
  TextEditingController searchController = TextEditingController();
  TextEditingController roomNameController = TextEditingController();
  ScrollController _searchUserController = ScrollController();
  HomeModel _model;
  @override
  void initState() {
    _model = widget.model;
    super.initState();
    _searchUserController.addListener(_searchScrollListenner);
  }

  _searchScrollListenner() async {
    if (_searchUserController.offset == 0.0) {
      await _model.loadmoreUserOnline();
    }
  }


  @override
  void dispose() {
    _searchUserController.removeListener(_searchScrollListenner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
              color: Colors.black38,
              border: Border(left: BorderSide(color: Colors.white, width: 1))),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Create Room",
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Gotu',
                            fontSize: 16),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.all(8),
                      child: ClipOval(
                        child: Material(
                          color: AppColor.actionColor,
                          child: InkWell(
                            splashColor: Colors.red,
                            onTap: () {
                              _model.createRoom(roomNameController.text);
                              searchController.clear();
                              roomNameController.clear();
                              _model.clearMemberAddToRoom();
                            },
                            child: SizedBox(
                              width: 42,
                              height: 42,
                              child: Icon(Icons.group_add),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Room name",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Gotu', fontSize: 12),
                  ),
                ),
              ),
              buildInput(roomNameController,
                  hintText: "Room name", onChange: (text) {}),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Members added",
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Gotu', fontSize: 12),
                  ),
                ),
              ),
              Expanded(
                  child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: SingleChildScrollView(
                  child: Wrap(
                    children: _model.memberInListAdd
                        .map((e) => SelectedItem(
                              name: e.fullName,
                              onRemoveClick: () {
                                _model.removeMemberInList(e);
                              },
                            ))
                        .toList(),
                  ),
                ),
              )),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Look for friends (${_model.totalOnline}/${_model.userOnlineOrigin.length - 1})",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                        color: Colors.white, fontFamily: 'Gotu', fontSize: 12),
                  ),
                ),
              ),
              buildInput(searchController, onChange: (text) {
                _model.searchUser(text);
              }, hintText: "Search user"),
              Expanded(
                  child: Container(
                // color: Colors.black38,
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: ListView.builder(
                    controller: _searchUserController,
                    itemCount: _model.userOnline.length,
                    itemBuilder: (context, index) {
                      return UserItem(
                        userName: _model.userOnline[index].fullName,
                        onAddClick: () async {
                          _model.addMemberInList(_model.userOnline[index]);
                        },
                      );
                    }),
              ))
            ],
          ),
        );
  }

  Widget buildInput(TextEditingController controller,
      {Function(String) onChange, String hintText}) {
    return Container(
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
      // color: Colors.black38,
      width: double.infinity,
      child: TextFormField(
          controller: controller,
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            hintStyle: TextStyle(
                color: AppColor.background, fontFamily: 'Gotu', fontSize: 14),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(90)),
              borderSide: BorderSide(color: AppColor.actionColor, width: 2),
            ),
          ),
          style: TextStyle(color: AppColor.background, fontFamily: 'Gotu'),
          onChanged: onChange),
    );
  }
}
