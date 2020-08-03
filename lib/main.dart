
import 'package:flutter/material.dart';

import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static const String route = '/myApp';

  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App People',
      home: LoginScreen(),
      routes: routes,

    );
  }
}

final routes = <String, Widget Function(BuildContext)>{
  LoginScreen.route: (_) => LoginScreen(),
  MyApp.route: (_) => MyApp(),
};