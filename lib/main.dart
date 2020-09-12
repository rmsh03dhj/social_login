
import 'package:barahi/home_screen.dart';
import 'package:barahi/service_locator.dart' as di;
import 'package:barahi/splash_screen.dart';
import 'package:barahi/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home_page.dart';
void main() async {
    await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

class MainScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.onAuthStateChanged,
      builder: (context, AsyncSnapshot<FirebaseUser> snapshot){
        if(snapshot.connectionState ==ConnectionState.waiting)
          return SplashScreen();
        if(!snapshot.hasData || snapshot.data ==null){
          return LoginPage();
        }
        return HomePage();
      }
    );
  }
}