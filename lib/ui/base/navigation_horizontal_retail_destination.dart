import 'package:flutter/material.dart';

class NavigationHorizontalRetailDestination extends StatefulWidget {
  final String title;
  final Widget icon;

  NavigationHorizontalRetailDestination(
      {this.title, this.icon});

  @override
  _NavigationHorizontalRetailDestinationState createState() =>
      _NavigationHorizontalRetailDestinationState();
}

class _NavigationHorizontalRetailDestinationState
    extends State<NavigationHorizontalRetailDestination> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Center(child: widget.icon),
          ),
           Expanded(
            flex: 3,
            child: Center(child: Text(widget.title)),
          ),
        ],
      ),
    );
  }
}
