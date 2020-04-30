import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/responsive.dart';
import 'package:focus_app/ui/modules/home/widgets/navigator/navigator.dart';
import 'package:focus_app/ui/modules/home/widgets/users/users.dart';

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
      child: Row(
        children: [
          Expanded(flex: 1, child: MainNavigator()),
          Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.black,
                        borderRadius: BorderRadius.all(Radius.circular(90))),
                  ),
                  Expanded(
                    child: ListView(
                      children: [
                        Users(),
                        Users(),
                        Users(),
                        Users(),
                      ],
                    ),
                  ),
                ],
              )),
          Expanded(
            flex: 6,
            child: Container(
              color: Colors.yellow,
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
