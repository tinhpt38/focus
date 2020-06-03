import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/app_color.dart';
import 'package:focus_app/ui/base/base_page.dart';
import 'package:focus_app/ui/base/navigation_horizontal_rail_destination.dart';
import 'package:focus_app/ui/base/navigation_rail.dart';
import 'package:focus_app/ui/base/responsive.dart';
import 'package:focus_app/ui/modules/home/home_model.dart';
import 'package:focus_app/ui/modules/home/widgets/chats/chat.dart';
import 'package:focus_app/ui/modules/home/widgets/search_user/user_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ResponsivePage {
  HomeModel _model;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BasePage<HomeModel>(
      model: _model == null ? HomeModel() : _model,
      builder: (context, model, child) {
        _model = model;
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
                            color: Colors.orange,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(
                            "tinhpt",
                            style: TextStyle(color: Colors.white, fontFamily: 'Gotu'),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: NavigationHorizontalRail(
                      backgroundColor: AppColor.background,
                      selectedColor: AppColor.actionColor,
                      selectedIndex: _model.indexSelected,
                      onChangeSelectedIndex: (index) {
                        _model.getMessageForUser(index);
                      },
                      destinations: _model.users
                          .map((e) => NavigationHorizontalRailDestination(
                                padding: EdgeInsets.symmetric(vertical: 8),
                                title: Container(
                                  child: Text(e,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Gotu'
                                      )),
                                ),
                                icon: Container(
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(12),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Text(e.substring(0, 1).toUpperCase(),
                                        style: TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                            fontFamily: 'Gotu'))),
                              ))
                          .toList(),
                    ),
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
                  color: AppColor.background,
                  border:
                      Border(left: BorderSide(color: Colors.white, width: 1))),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 12),
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 8),
                    color: Colors.black38,
                    width: double.infinity,
                    child: TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        filled: true,
                        fillColor: Colors.white,
                        hintText: "Search User",
                        hintStyle: TextStyle(
                            color: AppColor.background,
                            fontFamily: 'Gotu',
                            fontSize: 14),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(90)),
                          borderSide:
                              BorderSide(color: AppColor.actionColor, width: 2),
                        ),
                      ),
                      style: TextStyle(
                          color: AppColor.background, fontFamily: 'Gotu'),
                      onChanged: (text) {
                        _model.searchUser(text);
                      },
                    ),
                  ),
                  Expanded(
                      child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: ListView.builder(
                        itemCount: _model.userSearch.length,
                        itemBuilder: (context, index) {
                          return UserItem(
                            userName: _model.userSearch[index],
                            onAddClick: () {},
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
}
