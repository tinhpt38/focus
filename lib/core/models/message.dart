
import 'package:focus_app/ui/modules/home/widgets/chats/message.dart';

enum MessageType{
  location, voice, media, attach, text
}

class MessageModel{
  MessageType type;
  dynamic content;
  MessageForm messageForm;


  MessageModel({this.type, this.content, this.messageForm});
}