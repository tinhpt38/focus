import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/app_color.dart';

class Loading extends StatelessWidget {
  final String title;
  Loading({this.title = "Still setting the data..."});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            alignment: Alignment.center,
            child: CircularProgressIndicator(
                backgroundColor: Colors.red,
                valueColor:
                    new AlwaysStoppedAnimation<Color>(AppColor.actionColor)),
          ),
          Container(
            margin: EdgeInsets.all(12),
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {},
              splashColor: Colors.red,
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 24, fontFamily: 'Gotu', color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
