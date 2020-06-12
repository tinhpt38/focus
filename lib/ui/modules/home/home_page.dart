import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/app_color.dart';
import 'package:focus_app/ui/base/base_page.dart';
import 'package:focus_app/ui/base/loading.dart';
import 'package:focus_app/ui/base/navigation_horizontal_rail_destination.dart';
import 'package:focus_app/ui/base/navigation_rail.dart';
import 'package:focus_app/ui/base/responsive.dart';
import 'package:focus_app/ui/base/restart_widget.dart';
import 'package:focus_app/ui/modules/home/dialog/create_new_room.dart';
import 'package:focus_app/ui/modules/home/home_model.dart';
import 'package:focus_app/ui/modules/home/items/user_chat_item.dart';
import 'package:focus_app/ui/modules/home/widgets/chats/chat.dart';

class HomePage extends StatefulWidget {
  final HomeModel model;

  HomePage({this.model});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ResponsivePage {
  HomeModel _model;
  ScrollController _roomsController = ScrollController();

  @override
  void initState() {
    _model = widget.model;
    super.initState();
    _model.listenner();
    _roomsController.addListener(_roomsScrollListenner);
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _model.setBusy(true);
      await _model.getUserOnline();
      await _model.getRoomOfUserId();
      _model.setBusy(false);
    });
  }

  _roomsScrollListenner() async {
    if (_roomsController.offset == 0.0) {
      await _model.loadmoreRooms();
    }
  }

  @override
  void dispose() {
    _roomsController.removeListener(_roomsScrollListenner);
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
        return buildUi(context);
      },
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return buildTablet(context);
  }

  @override
  Widget buildMobile(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Container(
            color: Colors.black38,
            child: _model.rooms.isEmpty
                ? Container()
                : UserChatItem(
                    name: _model.rooms[_model.indexSelected].name,
                    backgroundColor: AppColor.background,
                  )),
        backgroundColor: AppColor.background,
        actions: [
          Container(
              margin: EdgeInsets.all(8),
              child: ClipOval(
                child: Material(
                  color: Colors.black.withOpacity(0.4),
                  child: InkWell(
                    splashColor: Colors.red,
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              child: Container(
                                color: AppColor.background,
                                padding: EdgeInsets.all(32),
                                child: Text(
                                  "Create new room doesn't support yet",
                                  style: TextStyle(
                                      fontFamily: "Gotu",
                                      color: Colors.red,
                                      fontSize: 16),
                                ),
                              ),
                            );
                          });
                    },
                    child: SizedBox(
                      width: 42,
                      height: 42,
                      child: Icon(
                        Icons.add,
                        color: AppColor.actionColor,
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
      body: Container(
        color: AppColor.background,
        child: ChatFlow(),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColor.background,
          width: size.width * (1 / 2),
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
                        style:
                            TextStyle(color: Colors.white, fontFamily: 'Gotu'),
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
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 4,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 8, right: 8),
                                    child: Text(e.name ?? "",
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Gotu')),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Visibility(
                                    visible:
                                        _model.roomIdHaveNewMessage[e.id] ??
                                            false,
                                    child: SizedBox(
                                      width: 12,
                                      height: 12,
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            shape: BoxShape.circle),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
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
          ),
        ),
      ),
    );
  }

  @override
  Widget buildTablet(BuildContext context) {
    return Scaffold(
      body: _model.busy
          ? Loading()
          : _model.isLogginOut
              ? Loading(
                  title:
                      "Application is logging out for ${_model.user.userName}",
                )
              : Container(
                  color: AppColor.headerColor,
                  child: Row(
                    children: [
                      Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Container(
                                color: Colors.black38,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 16),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.all(4),
                                      padding: EdgeInsets.all(8),
                                      decoration: BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle),
                                      child: Icon(
                                        Icons.person,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        _model.user.fullName ?? "",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Gotu'),
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
                                      .map((e) =>
                                          NavigationHorizontalRailDestination(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 8),
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  flex: 4,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 8, right: 8),
                                                    child: Text(e.name ?? "",
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontFamily:
                                                                'Gotu')),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 1,
                                                  child: Visibility(
                                                    visible:
                                                        _model.roomIdHaveNewMessage[
                                                                e.id] ??
                                                            false,
                                                    child: SizedBox(
                                                      width: 12,
                                                      height: 12,
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            icon: Container(
                                                alignment: Alignment.center,
                                                padding:
                                                    const EdgeInsets.all(12),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: Colors.white,
                                                ),
                                                child: Text(
                                                    e.name
                                                        .substring(0, 1)
                                                        .toUpperCase(),
                                                    style: TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                        fontFamily: 'Gotu'))),
                                          ))
                                      .toList(),
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
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
                              border: Border(
                                  left: BorderSide(
                                      color: Colors.white, width: 1))),
                          child: ChatFlow(),
                        ),
                      ),
                      Expanded(flex: 3, child: CreateNewRoom(_model)),
                    ],
                  ),
                ),
    );
  }
}
