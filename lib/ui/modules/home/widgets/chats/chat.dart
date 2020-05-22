import 'package:flutter/material.dart';
import 'package:focus_app/core/models/message.dart';
import 'package:focus_app/ui/base/app_color.dart';
import 'package:focus_app/ui/base/common.dart';
import 'package:focus_app/ui/modules/home/home_model.dart';
import 'package:focus_app/ui/modules/home/home_page.dart';
import 'package:focus_app/ui/modules/home/widgets/chats/message.dart';
import 'package:provider/provider.dart';

enum ChatAction { location, voice, picture, attach, text, send }
List<ChatAction> chatActions = [
  ChatAction.location,
  ChatAction.voice,
  ChatAction.picture,
  ChatAction.attach,
  ChatAction.text,
  ChatAction.send
];

class ChatFlow extends StatefulWidget {
  @override
  _ChatFlowState createState() => _ChatFlowState();
}

class _ChatFlowState extends State<ChatFlow> {
  FocusNode textNode;

  TextEditingController textController = TextEditingController();
  ScrollController chatController;
  HomeModel _model;

  @override
  void initState() {
    textNode = FocusNode();
    chatController = ScrollController();
    super.initState();
  }

  void scrollToEnd() {
    if (!chatController.hasClients) {
      return;
    }

    var scrollPosition = chatController.position;

    if (scrollPosition.maxScrollExtent > scrollPosition.minScrollExtent) {
      chatController.animateTo(
        scrollPosition.maxScrollExtent + 100,
        duration: new Duration(milliseconds: 100),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    textNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (context, model, child) {
        _model = model;
        return Container(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(color: Colors.black38),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(16),
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColor.actionColor,
                      ),
                      child: Icon(Icons.people),
                    ),
                    Text(
                      "NO 1",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView.builder(
                controller: chatController,
                itemCount: model.messages.length,
                itemBuilder: (context, index) {
                  return Message(model.messages[index]);
                },
              )),
              Container(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                  ),
                  child: Row(
                    children: chatActions
                        .asMap()
                        .map((key, action) =>
                            MapEntry(action, actionItem(action)))
                        .values
                        .toList(),
                  )),
            ],
          ),
        );
      },
    );
  }

  Widget actionItem(ChatAction action) {
    switch (action) {
      case ChatAction.location:
        {
          return extentionAction(Icons.location_on, () {});
        }
      case ChatAction.voice:
        {
          return extentionAction(Icons.mic, () {});
        }
      case ChatAction.picture:
        {
          return extentionAction(Icons.image, () {});
        }
      case ChatAction.attach:
        {
          return extentionAction(Icons.attach_file, () {});
        }
      case ChatAction.text:
        {
          return Expanded(
            flex: 5,
            child: Container(
              child: TextField(
                autofocus: true,
                controller: textController,
                textInputAction: TextInputAction.done,
                onSubmitted: (text) {
                  setState(() {
                    _model.messages.add(MessageModel(
                        messageForm: MessageForm.owner,
                        content: text,
                        type: MessageType.text));
                    textController.text = "";
                  });
                  scrollToEnd();
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Aa",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(90)))),
              ),
            ),
          );
        }
      case ChatAction.send:
        {
          return extentionAction(Icons.send, () {});
        }
      default:
        return Text("No action");
    }
  }

  Widget extentionAction(IconData icon, Function onClick) {
    return Expanded(
      flex: 1,
      child: FlatButton(
        onPressed: () {},
        child: AspectRatio(
          aspectRatio: 1,
          child: Icon(
            icon,
            color: AppColor.actionColor,
            size: 32,
          ),
        ),
      ),
    );
  }
}
