import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class BasePage<T extends ChangeNotifier> extends StatefulWidget {

  final T model;
  final Function(BuildContext context, T model, Widget child) builder;
  final Widget chid;

  BasePage({this.model, this.builder, this.chid});

  @override
  _BasePageState<T> createState() => _BasePageState<T>();
}

class _BasePageState<T extends ChangeNotifier> extends State<BasePage<T>> {


  T model;
  @override
  void initState() {
    model = widget.model;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<T>.value(
      value: model,
      child: Consumer<T>(
        builder: widget.builder,
        child: widget.chid,
      ),
    );
  }
}