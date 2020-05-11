import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/responsive.dart';

class ChatID extends StatefulWidget {
  @override
  _ChatIDState createState() => _ChatIDState();
}

class _ChatIDState extends State<ChatID> with ResponsivePage {
  @override
  Widget build(BuildContext context) {
    return buildUi(context);
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return buildTablet(context);
  }

  @override
  Widget buildMobile(BuildContext context) {
    return Container(
      color: Color(0xff485565),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12),
            decoration:
                BoxDecoration(color: Colors.white, shape: BoxShape.circle),
            child: Icon(Icons.people),
          ),
        ],
      ),
    );
  }

  @override
  Widget buildTablet(BuildContext context) {
    return Container(
      color: Color(0xff485565),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: Stack(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(12),
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Icon(Icons.people),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                "mac mi",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Container(
          width: 16,
          height: 16,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: Color(0xff71D698)),
        ),
      ]),
    );
  }
}
