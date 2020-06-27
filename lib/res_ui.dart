import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/responsive.dart';

class ResUI extends StatelessWidget with ResponsivePage {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildUi(context),
    );
  }

  @override
  Widget buildDesktop(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      color: Colors.redAccent,
      child: Text("UI for Desktop"),
    );
  }

  @override
  Widget buildMobile(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.yellowAccent,
      child: Text("UI for Mobile"),
    );
  }

  @override
  Widget buildTablet(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      color: Colors.blueAccent,
      child: Text("UI for Tablet"),
    );
  }
}
