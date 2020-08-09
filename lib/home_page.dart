import 'package:barahi/auth_provider.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Title"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("HomePage"),
              RaisedButton(
                child: Text("Logout"),
                onPressed: () async {
                  AuthProvider().emailSignOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}