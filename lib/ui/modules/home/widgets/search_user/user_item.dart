import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/app_color.dart';
import 'package:focus_app/ui/modules/home/home_model.dart';
import 'package:provider/provider.dart';

class UserItem extends StatelessWidget {
  final String userName;
  final Function onAddClick;
  UserItem({this.userName, this.onAddClick});
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeModel>(
      builder: (context, model, child) {
        return Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(180))),
          margin: EdgeInsets.symmetric(vertical: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: Text(userName.substring(0, 1).toUpperCase(),
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Gotu',
                          fontSize: 16))),
              Container(
                child: Text(userName,
                    style: TextStyle(
                      color: Colors.black,
                    )),
              ),
              Container(
                  margin: EdgeInsets.all(8),
                  child: ClipOval(
                    child: Material(
                      color: AppColor.actionColor, // button color
                      child: InkWell(
                        splashColor: Colors.red,
                        onTap: onAddClick,
                        child: SizedBox(
                          width: 42,
                          height: 42,
                          child: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        );
      },
    );
  }
}
