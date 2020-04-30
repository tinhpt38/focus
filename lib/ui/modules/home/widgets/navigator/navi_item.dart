import 'package:flutter/material.dart';

class NaviItem extends StatefulWidget {
  @override
  _NaviItemState createState() => _NaviItemState();
}

class _NaviItemState extends State<NaviItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 24),
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Visibility(
                  visible: true,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 12),
                    width: 12,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.all(Radius.circular(32))
                    ),
                  ),
                ),
                Container(
                  margin:  EdgeInsets.only(right:12),
                  color: Colors.black,
                  child: Icon(
                    Icons.message,
                    color: Colors.white,
                    size: 64,
                  ),
                ),
              ],
            ),
            Container(
              width: 24,
              height: 24,
              decoration:
                  BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            ),
          ],
        ),
      ),
    );
  }
}
