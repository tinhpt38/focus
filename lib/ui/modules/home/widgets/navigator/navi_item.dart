import 'package:flutter/material.dart';

class NaviItem extends StatefulWidget {
  final IconData icon;
  final Function(bool) onSelect;
  final bool isSelect;
  final bool isNotification;

  NaviItem(
      {this.icon, this.onSelect, this.isSelect = false, this.isNotification = false});

  @override
  _NaviItemState createState() => _NaviItemState();
}

class _NaviItemState extends State<NaviItem> {
  bool isSelected;

  @override
  void initState() {
    isSelected = widget.isSelect;
    super.initState();
  }

  onSelect() {
    widget.onSelect(!isSelected);
    setState(() {
      isSelected = !isSelected;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
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
                    visible: isSelected,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 8),
                      width: 8,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(32))),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 12),
                    child: Icon(
                      widget.icon,
                      color: Colors.white,
                      size: 42,
                    ),
                  ),
                ],
              ),
              Visibility(
                visible: widget.isNotification,
                child: Container(
                  width: 16,
                  height: 16,
                  margin: EdgeInsets.only(right: 8),
                  decoration:
                      BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
