import 'package:flutter/material.dart';
import 'package:focus_app/core/models/message.dart';
import 'package:focus_app/ui/base/app_color.dart';

enum MessageForm { owner, homie }

class Message extends StatefulWidget {
  final MessageModel message;

  Message(this.message);

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  
  bool isOwner;



  @override
  void initState() {
    isOwner = widget.message.messageForm == MessageForm.owner;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment: isOwner? MainAxisAlignment.end: MainAxisAlignment.start,
        children: [
          Visibility(
            visible: !isOwner,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.all(12),
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Icon(
                Icons.people,
                size: 38,
              ),
            ),
          ),
          buildMessage(size, widget.message),
          Visibility(
            visible: isOwner,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 12),
              padding: EdgeInsets.all(12),
              decoration:
                  BoxDecoration(color: Colors.white, shape: BoxShape.circle),
              child: Icon(
                Icons.people,
                size: 38,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMessage(Size size, MessageModel message) {
    EdgeInsets margin = isOwner? EdgeInsets.only(left: size.width * (1 / 4)): EdgeInsets.only(right: size.width * (1 / 4));
    return Expanded(
      child: Container(
          margin: margin,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: AppColor.messageBg,
              borderRadius: BorderRadius.all(Radius.circular(32))),
          child: buildMessageype(message)),
    );
  }

  Widget buildMessageype(MessageModel message) {
    switch (message.type) {
      case MessageType.text:
        return Text(message.content, textAlign: TextAlign.start);
      case MessageType.picture:
        return Image.network(message.content,fit: BoxFit.fill,);
      default:
        return Text(message.content, textAlign: TextAlign.start);
    }
  }
}
