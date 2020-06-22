import 'dart:math';

import 'package:flutter/material.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/ui/base/app_color.dart';
import 'package:focus_app/ui/base/base_page.dart';
import 'package:focus_app/ui/base/loading.dart';
import 'package:focus_app/ui/base/navigation_horizontal_rail_destination.dart';
import 'package:focus_app/ui/base/navigation_rail.dart';
import 'package:focus_app/ui/base/responsive.dart';
import 'package:focus_app/ui/base/restart_widget.dart';
import 'package:focus_app/ui/modules/admin/admin_page_model.dart';
import 'package:focus_app/ui/modules/home/widgets/chats/chat.dart';

class AdminPage extends StatefulWidget {
  final User user;

  AdminPage({this.user});
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> with ResponsivePage {
  AdminModel _model;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _model.listenner();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BasePage<AdminModel>(
      model: AdminModel(user: widget.user),
      builder: (context, model, child) {
        _model = model;
        Future.delayed(Duration.zero, () {
          if (model.isLogout) {
            RestarApp.restartApp(context);
          }
        });
        return Scaffold(
          body: buildUi(context),
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
    return Scaffold(
      body: Center(
        child: Text("Application isn't support for this size!"),
      ),
    );
  }

  @override
  Widget buildTablet(BuildContext context) {
    return Container(
      color: AppColor.headerColor,
      child: _model.busy
          ? Loading()
          : _model.isLogginOut
              ? Loading(
                  title:
                      "Application is logging out for ${_model.user.userName}",
                )
              : Row(
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
                                        color: Colors.black,
                                        shape: BoxShape.circle),
                                    child: Icon(
                                      Icons.person,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 8),
                                    child: Text(
                                      _model.user.fullName,
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
                                // controller: _roomsController,
                                backgroundColor: AppColor.background,
                                selectedColor: AppColor.actionColor,
                                selectedIndex: 0,
                                onChangeSelectedIndex: (index) {
                                  // _model.changeIndexSelected(index);
                                  //
                                },
                                destinations: _model.userOnlineList
                                    .map((e) =>
                                        NavigationHorizontalRailDestination(
                                          padding:
                                              EdgeInsets.symmetric(vertical: 8),
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                flex: 4,
                                                child: Container(
                                                  margin: EdgeInsets.only(
                                                      left: 8, right: 8),
                                                  child: Text(e.userName ?? "",
                                                      maxLines: 2,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontFamily: 'Gotu')),
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
                                                  e.fullName
                                                      .split(" ")
                                                      .last
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
                            border: Border(
                                left:
                                    BorderSide(color: Colors.white, width: 1))),
                        child: ChatFlow(),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Container(
                          color: Colors.red,
                          //todo: left content
                        )),
                  ],
                ),
    );
  }
}
