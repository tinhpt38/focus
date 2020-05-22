
import 'package:focus_app/core/models/message.dart';
import 'package:focus_app/ui/base/base_page_model.dart';
import 'package:focus_app/ui/base/common.dart';
import 'package:focus_app/ui/modules/home/widgets/chats/message.dart';

class HomeModel extends PageModel{
  List<String> _users = [
    "Mi","Hai","Lam","Bang","Ha","Hanh","Huy"
  ];
  int _indexSelected = 0;
  int get indexSelected => _indexSelected;
  List<String> get users => _users;
   List<MessageModel> messages = [
    MessageModel(
        type: MessageType.text,
        content: textTest1,
        messageForm: MessageForm.homie),
    MessageModel(
        type: MessageType.text,
        content: textTest1,
        messageForm: MessageForm.owner),
    MessageModel(
        type: MessageType.text,
        content: textTest1,
        messageForm: MessageForm.owner),
    MessageModel(
        type: MessageType.text,
        content: textTest1,
        messageForm: MessageForm.homie),
  ];

  setUsers(List<String> value){
    _users = value;
    notifyListeners();
  }

  getMessageForUser(int index)async{
    _indexSelected = index;
    notifyListeners();
  }
}