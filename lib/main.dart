import 'package:flutter/material.dart';
import 'package:focus_app/ui/base/restart_widget.dart';
import 'package:focus_app/ui/modules/auth/login/login_page.dart';

void main() {
  runApp(RestarApp(child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Homie',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LoginPage(),
    );
  }
}
