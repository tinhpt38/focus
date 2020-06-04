
enum MessageType{
  location, voice, media, attach, text,
  link
}

class MessageModel{
  MessageType type;
  dynamic content;
  String idSender;
  MessageModel({this.type, this.content, this.idSender});
}