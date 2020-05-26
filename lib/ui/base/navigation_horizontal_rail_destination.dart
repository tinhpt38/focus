import 'package:flutter/material.dart';

class NavigationHorizontalRailDestination extends StatefulWidget {
  
  final Widget title;
  final Widget icon;
  final EdgeInsets padding;

  NavigationHorizontalRailDestination(
      {this.title, this.icon, this.padding});

  @override
  _NavigationHorizontalRailDestinationState createState() =>
      _NavigationHorizontalRailDestinationState();
}

class _NavigationHorizontalRailDestinationState
    extends State<NavigationHorizontalRailDestination> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: widget.padding,
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(child: widget.icon),
          ),
           Expanded(
            flex: 3,
            child: Center(child: widget.title),
          ),
        ],
      ),
    );
  }
}
