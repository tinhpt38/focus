import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/navigation_horizontal_retail_destination.dart';

class NavigationHorizontalRetail extends StatefulWidget {
  final Color backgroundColor;
  final Color selectedColor;
  final Function(int) onChangeSelectedIndex;
  final int selectedIndex;
  final List<NavigationHorizontalRetailDestination> destinations;

  NavigationHorizontalRetail(
      {this.backgroundColor,
      this.onChangeSelectedIndex,
      this.destinations,
      this.selectedColor,
      this.selectedIndex});

  @override
  _NavigationHorizontalRetailState createState() =>
      _NavigationHorizontalRetailState();
}

class _NavigationHorizontalRetailState
    extends State<NavigationHorizontalRetail> {
  int indexSelected = -1;


  @override
  void initState() {
    indexSelected = widget.selectedIndex;  
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: widget.backgroundColor,
        child: ListView.builder(
          itemCount: widget.destinations.length,
          itemBuilder: (context, index) => FlatButton(
            color: indexSelected == index
                ? widget.selectedColor
                : Colors.transparent,
            onPressed: () {
              widget.onChangeSelectedIndex(index);
              setState(() => indexSelected = index);
            },
            child: widget.destinations[index],
          ),
        ));
  }
}
