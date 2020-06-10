import 'package:flutter/material.dart';

class RestarApp extends StatefulWidget {
  final Widget child;

  RestarApp({this.child});

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestarAppState>().restartApp();
  }

  @override
  _RestarAppState createState() => _RestarAppState();
}

class _RestarAppState extends State<RestarApp> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(key: key, child: widget.child);
  }
}
