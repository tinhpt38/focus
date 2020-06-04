import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:focus_app/core/models/message.dart';
import 'package:focus_app/core/models/user.dart';
import 'package:focus_app/ui/base/app_color.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:focus_app/ui/base/common.dart';
import 'package:provider/provider.dart';

class Message extends StatefulWidget {
  final MessageModel message;
  final User user;

  Message({this.user, this.message});

  @override
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool isOwner = widget.message.idSender == widget.user.id;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24),
      child: Row(
        mainAxisAlignment:
            isOwner ? MainAxisAlignment.end : MainAxisAlignment.start,
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
          buildMessage(size, widget.message, isOwner),
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

  Widget buildMessage(Size size, MessageModel message, bool isOwner) {
    Alignment alignment =
        isOwner ? Alignment.centerRight : Alignment.centerLeft;
    EdgeInsets margin =
        isOwner ? EdgeInsets.only(left: 42) : EdgeInsets.only(right: 42);
    return Expanded(
      child: Container(
          margin: margin,
          alignment: alignment,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
              color: AppColor.messageBg,
              borderRadius: BorderRadius.all(Radius.circular(12))),
          child: buildMessageype(size, message)),
    );
  }

  Widget buildMessageype(Size size, MessageModel message) {
    switch (message.type) {
      case MessageType.text:
        {
          return SelectableText(message.content, textAlign: TextAlign.start);
        }
      case MessageType.media:
        {
          try {
            return FutureBuilder<List<int>>(
                future: message.content.readAsBytes(),
                builder: (context, snapshot) {
                  final _bytes = Uint8List.fromList(snapshot.data);
                  return Image.memory(
                    _bytes,
                    fit: BoxFit.contain,
                  );
                });
          } catch (_) {}
          return Container(
            child: Icon(Icons.error),
          );
        }
      case MessageType.link:
        {

          bool isImage = false;
          imageExtentions.forEach((extention) { 
            if(message.content.toString().toLowerCase().contains(extention)){
              isImage = true;
            }
          });
          if (isImage) {
            try {
              return CachedNetworkImage(
                imageUrl: message.content,
                imageBuilder: (context, imageProvider) {
                  return SizedBox(
                    child: Container(
                      child: Image(
                        image: imageProvider,
                      ),
                    ),
                  );
                },
                placeholder: (context, _) {
                  return Center(child: CircularProgressIndicator());
                },
                errorWidget: (context, url, errr) {
                  return SelectableText(message.content,
                      textAlign: TextAlign.start);
                },
              );
            } catch (e) {
              print("User Exception: ${e.toString()}");
            }
          }
          return SelectableText(message.content, textAlign: TextAlign.start);
        }
      default:
        return SelectableText(message.content, textAlign: TextAlign.start);
    }
  }
}
