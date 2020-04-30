import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/app_color.dart';
import 'package:focus_app/ui/base/responsive.dart';
import 'package:focus_app/ui/modules/home/widgets/chats/chat.dart';
import 'package:focus_app/ui/modules/home/widgets/chats/chat_id.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with ResponsivePage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildUi(context),
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
      color: Color(0xff363E48),
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
                            style: TextStyle(
                              color: Colors.white
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        ChatID(),
                        ChatID(),
                        ChatID(),
                        ChatID(),
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 6,
            child: Container(
              color: AppColor.background,
              child: ChatFlow(),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }
}
