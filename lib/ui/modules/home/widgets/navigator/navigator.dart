import 'package:flutter/material.dart';
import 'package:focus_app/ui/modules/home/widgets/navigator/navi_item.dart';


class MainNavigator extends StatefulWidget {
  @override
  _MainNavigatorState createState() => _MainNavigatorState();
}

class _MainNavigatorState extends State<MainNavigator> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff303842),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white
            ),
            child: Icon(
              Icons.people,
              size: 64,
            ),
          ),
            NaviItem(),
            NaviItem(),
            NaviItem(),
            Spacer(),
            NaviItem(),
        ],
      ),      
    );
  }
}
