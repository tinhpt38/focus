import 'package:flutter/material.dart';



class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent,
      padding: const EdgeInsets.symmetric(vertical: 32),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              child: Icon(Icons.people),
            )
          ),
          Expanded(
            flex: 3,
            child: Column(
              children: [
                Text(
                  "Mac Mi"
                ),
                Text(
                  "Hi how Are U"
                ),
              ],
            )
          ),
          Expanded(
            flex: 1,
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                shape: BoxShape.circle
              ),
            )
          ),
        ],
      ),
    );
  }
}