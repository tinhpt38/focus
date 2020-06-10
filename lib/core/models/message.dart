
enum MessageType { location, voice, media, attach, text, link }

class MessageModel {
  dynamic type;
  dynamic content;
  dynamic idSender;
  dynamic roomId;
  MessageModel({this.type, this.content, this.idSender, this.roomId});

  MessageModel.formJson(Map<String, dynamic> json)
      : this.type = json["type"],
        this.content = json["content"],
        this.idSender = json["sender"],
        this.roomId = json["room"];

  Map<String, dynamic> toJson() => {
        "type": this.type,
        "content": this.content,
        "sender": this.idSender,
        "room": this.roomId
      };
}
