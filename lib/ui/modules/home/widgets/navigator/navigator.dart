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
              Icons.person,
              size: 64,
            ),
          ),
            NaviItem(
              icon: Icons.message,
              onSelect: (_isSelect){},
              isSelect: true,
              isNotification: true,
            ),
            NaviItem(
              icon: Icons.person,
              onSelect: (_isSelect){},
              isNotification: true,
            ),
            NaviItem(
              icon: Icons.group_add,
              onSelect: (_isSelect){},
            ),
            Spacer(),
            NaviItem(
              icon: Icons.leak_remove,
              onSelect: (_isSelect){},
            ),
        ],
      ),      
    );
  }
}
