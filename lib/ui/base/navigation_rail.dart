import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/navigation_horizontal_rail_destination.dart';

class NavigationHorizontalRail extends StatefulWidget {
  final Color backgroundColor;
  final Color selectedColor;
  final Color splashColor;
  final Function(int) onChangeSelectedIndex;
  final int selectedIndex;
  final List<NavigationHorizontalRailDestination> destinations;
  final ScrollController controller;

  NavigationHorizontalRail(
      {this.backgroundColor,
      this.onChangeSelectedIndex,
      this.destinations,
      this.selectedColor,
      this.splashColor = Colors.red,
      this.selectedIndex, 
      this.controller});

  @override
  _NavigationHorizontalRailState createState() =>
      _NavigationHorizontalRailState();
}

class _NavigationHorizontalRailState
    extends State<NavigationHorizontalRail> {

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
          controller: widget.controller,
          itemCount: widget.destinations.length,
          itemBuilder: (context, index) => FlatButton(
            splashColor: widget.splashColor,
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
