import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/app_color.dart';

class Loadmore extends StatefulWidget {
  final Function onLoadmoreClick;

  Loadmore({this.onLoadmoreClick});
  @override
  _LoadmoreState createState() => _LoadmoreState();
}

class _LoadmoreState extends State<Loadmore> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onLoadmoreClick,
      splashColor: Colors.red,
      child: Container(
        decoration: BoxDecoration(
          color: AppColor.actionColor,
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        alignment: Alignment.center,
        child: Text("Click me to get more messages",
            style: TextStyle(
                color: Colors.black, fontFamily: "Gotu", fontSize: 16)),
      ),
    );
  }
}
