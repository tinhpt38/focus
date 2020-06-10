import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/app_color.dart';


class SelectedItem extends StatelessWidget {
  final String name;
  final Function onRemoveClick;
  SelectedItem({this.name, this.onRemoveClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColor.actionColor,
        borderRadius: BorderRadius.all(Radius.circular(90)),
      ),
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              name,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Gotu",
                fontSize: 14
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: InkWell(
                onTap: onRemoveClick,
                splashColor: Colors.red,
                child: Icon(
                  Icons.remove_circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ]
      ),
    );
  }
}