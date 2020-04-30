import 'package:flutter/material.dart';



class ChatID extends StatefulWidget {
  @override
  _ChatIDState createState() => _ChatIDState();
}

class _ChatIDState extends State<ChatID> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff485565),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle
            ),
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
          Spacer(),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xff71D698)
            ),
          )
        ],
      ),
    );
  }
}