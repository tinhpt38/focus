import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/app_color.dart';
import 'package:focus_app/ui/base/base_page.dart';
import 'package:focus_app/ui/base/loading.dart';
import 'package:focus_app/ui/base/navigation_horizontal_rail_destination.dart';
import 'package:focus_app/ui/base/navigation_rail.dart';
import 'package:focus_app/ui/base/responsive.dart';
import 'package:focus_app/ui/base/restart_widget.dart';
import 'package:focus_app/ui/modules/home/home_model.dart';
import 'package:focus_app/ui/modules/home/widgets/chats/chat.dart';
import 'package:focus_app/ui/modules/home/widgets/search_user/select_item.dart';
import 'package:focus_app/ui/modules/home/widgets/search_user/user_item.dart';

class HomePage extends StatefulWidget {
  final HomeModel model;

  HomePage({this.model});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ResponsivePage {
  HomeModel _model;
  TextEditingController searchController = TextEditingController();
  TextEditingController roomNameController = TextEditingController();
  ScrollController _searchUserController = ScrollController();
  ScrollController _roomsController = ScrollController();

  @override
  void initState() {
    _model = widget.model;
    super.initState();
    _model.listenner();
    _searchUserController.addListener(_searchScrollListenner);
    _roomsController.addListener(_roomsScrollListenner);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _model.setBusy(true);
      await _model.getUserOnline();
      await _model.getRoomOfUserId();
      _model.autoJoinRoom();
      _model.setBusy(false);
    });
  }

  _searchScrollListenner() async {
    if (_searchUserController.offset == 0.0) {
      await _model.loadmoreUserOnline();
    }
  }

  _roomsScrollListenner() async {
    if (_roomsController.offset == 0.0) {
      await _model.loadmoreRooms();
    }
  }

  @override
  void dispose() {
    _roomsController.removeListener(_roomsScrollListenner);
    _searchUserController.removeListener(_searchScrollListenner);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BasePage<HomeModel>(
      model: widget.model,
      builder: (context, model, child) {
        _model = model;
        Future.delayed(Duration.zero, () {
          if (model.isLogout) {
            RestarApp.restartApp(context);
          }
        });
        return Scaffold(
          body: model.busy
              ? Loading()
              : model.isLogginOut
                  ? Loading(
                      title:
                          "Application is logging out for ${_model.user.userName}",
                    )
                  : buildUi(context),
        );
      },
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return buildTablet(context);
  }

  @override
  Widget buildMobile(BuildContext context) {
    return buildTablet(context);
  }

  @override
  Widget buildTablet(BuildContext context) {
    return Container(
      color: AppColor.headerColor,
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Column(
                children: [
                  Container(
                    color: Colors.black38,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.all(4),
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              color: Colors.black, shape: BoxShape.circle),
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            _model.user.fullName ?? "",
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Gotu'),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: NavigationHorizontalRail(
                      controller: _roomsController,
                      backgroundColor: AppColor.background,
                      selectedColor: AppColor.actionColor,
                      selectedIndex: _model.indexSelected,
                      onChangeSelectedIndex: (index) {
                        _model.changeIndexSelected(index);
                      },
                      destinations: _model.rooms
                          .map((e) => NavigationHorizontalRailDestination(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                title: Container(
                                  child: Text(e.name ?? "",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Gotu')),
                                ),
                                icon: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Text(
                                        e.name.substring(0, 1).toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: 'Gotu'))),
                              ))
                          .toList(),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    color: Colors.black38,
                    child: InkWell(
                        onTap: () async {
                          await _model.logout();
                        },
                        splashColor: AppColor.actionColor,
                        child: Transform.rotate(
                          angle: pi,
                          child: Icon(
                            Icons.exit_to_app,
                            size: 46,
                            color: Colors.red,
                          ),
                        )),
                  ),
                ],
              )),
          Expanded(
            flex: 6,
            child: Container(
              decoration: BoxDecoration(
                  color: AppColor.background,
                  border:
                      Border(left: BorderSide(color: Colors.white, width: 1))),
              child: ChatFlow(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.black38,
                  border:
                      Border(left: BorderSide(color: Colors.white, width: 1))),
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
                            color: Colors.white,
                            fontFamily: 'Gotu',
                            fontSize: 12),
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
                            color: Colors.white,
                            fontFamily: 'Gotu',
                            fontSize: 12),
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
                            color: Colors.white,
                            fontFamily: 'Gotu',
                            fontSize: 12),
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
            ),
          ),
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
