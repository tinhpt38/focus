import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/app_color.dart';

class UserChatItem extends StatelessWidget {
  final String name;
  final Color backgroundColor;
  UserChatItem({this.name, this.backgroundColor = Colors.black38});
  @override
  Widget build(BuildContext context) {
    return Container(      
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: backgroundColor),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8),
            margin: EdgeInsets.all(4),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColor.actionColor,
            ),
            child: Icon(Icons.people),
          ),Text(
                  name,
                  style: TextStyle(color: Colors.white, fontFamily: 'Gotu'),
                )
        ],
      ),
    );
  }
}
