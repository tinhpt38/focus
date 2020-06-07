import 'package:flutter/material.dart';
import 'package:focus_app/core/models/room.dart';
import 'package:focus_app/ui/base/app_color.dart';

class InviteIntoRoomDialog extends StatelessWidget {
  final Room room;
  final Function onCancelClick;
  final Function(String) onAcceptClick;
  InviteIntoRoomDialog({this.room, this.onAcceptClick, this.onCancelClick});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        color: AppColor.background,
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "You have been invite in to ${room.name} chat",
                style: TextStyle(fontFamily: "Gotu", fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Room ID: ${room.name}',
                style: TextStyle(fontFamily: "Gotu", fontSize: 16),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Owner ID: ${room.id}',
                style: TextStyle(fontFamily: "Gotu", fontSize: 16),
              ),
            ),
                  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    splashColor: AppColor.actionColor,
                    onTap:(){
                      onAcceptClick(room.id);
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(90))
                      ),
                      child: Text(
                        "Accept",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                   InkWell(
                    splashColor: Colors.red,
                    onTap:onCancelClick,
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(90))
                      ),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ),
          ],
        ),
      ),
    );
  }
}
