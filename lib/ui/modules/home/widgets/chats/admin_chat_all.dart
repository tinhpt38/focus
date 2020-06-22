import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/app_color.dart';
import 'package:focus_app/ui/base/loading.dart';
import 'package:focus_app/ui/modules/admin/admin_page_model.dart';
import 'package:focus_app/ui/modules/home/home_model.dart';
import 'package:focus_app/ui/modules/home/items/user_chat_item.dart';
import 'package:focus_app/ui/modules/home/widgets/chats/chat.dart';
import 'package:focus_app/ui/modules/home/widgets/chats/message.dart';
import 'package:provider/provider.dart';
import 'package:file_access/file_access.dart';

class ChatFlowAdmin extends StatefulWidget {
  final bool isDisableUser;

  ChatFlowAdmin({this.isDisableUser = false});
  @override
  _ChatFlowAdminState createState() => _ChatFlowAdminState();
}

class _ChatFlowAdminState extends State<ChatFlowAdmin> {
  FocusNode textNode;

  TextEditingController textController = TextEditingController();
  ScrollController chatController;
  AdminModel _model;
  FileX fileX;

  @override
  void initState() {
    textNode = FocusNode();
    chatController = ScrollController();
    super.initState();
    chatController.addListener(listennerScroll);
  }

  listennerScroll() {
    // if (chatController.offset == 0.0) {
    //   _model.loadmoreMessageForRoom();
    // }
  }

  void scrollToEnd() {
    if (chatController != null) {
      var scrollPosition = chatController.position;
      if (scrollPosition.maxScrollExtent > scrollPosition.minScrollExtent) {
        chatController.animateTo(
          scrollPosition.maxScrollExtent + 100,
          duration: new Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    }
  }

  @override
  void dispose() {
    textNode.dispose();
    chatController.removeListener(listennerScroll);
    chatController.dispose();
    super.dispose();
  }

  void addMessage(String text) {
    if (text.isNotEmpty) {
      String mst = text.contains("http") ? "LINK" : "TEXT";
      _model.addMessage(content: text, type: mst);
      setState(() {
        textController.clear();
      });
      textNode.requestFocus();
      scrollToEnd();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AdminModel>(
      builder: (context, model, child) {
        _model = model;
        return Container(
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Column(
                children: [
                  Expanded(
                      child: model.messageAll == null ||
                              model.messageAll.isEmpty
                          ? Container()
                          : ListView.builder(
                                  controller: chatController,
                                  itemCount: model.messageAll.length,
                                  itemBuilder: (context, index) {
                                    return Message(
                                        message: model.messageAll[index],
                                        user: _model.user);
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
          return extentionAction(Icons.image, () async {
            final _file = await pickImage();
            if (_file != null) {
              List<int> imageByte = await _file.readAsBytes();
              _model.addMessage(type: "MEDIA", content: imageByte);
            }
          });
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
              margin: const EdgeInsets.only(left:24),
              child: TextField(
                autofocus: true,
                focusNode: textNode,
                controller: textController,
                textInputAction: TextInputAction.done,
                onSubmitted: (text) {
                  addMessage(text);
                },
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    hintText: "Aa",
                    hintStyle: TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: AppColor.actionColor, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(90)))),
              ),
            ),
          );
        }
      case ChatAction.send:
        {
          return extentionAction(Icons.send, () {
            addMessage(textController.text);
          });
        }
      default:
        return Text("No action");
    }
  }

  Widget extentionAction(IconData icon, Function onClick) {
    return Expanded(
      flex: 1,
      child: FlatButton(
        onPressed: onClick,
        splashColor: Colors.red,
        child: Icon(
          icon,
          color: AppColor.actionColor,
          size: 32,
        ),
      ),
    );
  }
}
