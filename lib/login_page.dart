import 'package:auto_validating_text_field/auto_validating_text_field.dart';
import 'package:barahi/auth_provider.dart';
import 'package:flutter/material.dart';

import 'validators.dart';

class LoginPage extends StatefulWidget {
  static const String route = '/loginScreen';

  @override
  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _userNameFocusNode = FocusNode();
  FocusNode _passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Center(child: Text("Login Screen")),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Container(
                height: 30,
              ),
              SizedBox(height: 50),
              Container(
                  width: 250,
                  child: Text(
                    "User Name",
                    style: TextStyle(fontSize: 16),
                  )),
              Container(
                width: 250,
                child: AutoValidatingTextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter user name",
                  ),
                  focusNode: _userNameFocusNode,
                  controller: _userNameController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  validators: [
                    Validators.required(),
                  ],
                  onFieldSubmitted: (_) {
                    fieldFocusChange(context, _userNameFocusNode, _passwordFocusNode);
                  },
                ),
              ),
              SizedBox(height: 20),
              Container(
                  width: 250,
                  child: Text(
                    "Password",
                    style: TextStyle(fontSize: 16),
                  )),
              Container(
                width: 250,
                child: AutoValidatingTextFormField(
                  decoration: InputDecoration(
                    hintText: "Enter password",
                  ),
//                  obscureText: true,
                  focusNode: _passwordFocusNode,
                  controller: _passwordController,
                  keyboardType: TextInputType.text,
                  validators: [
                    Validators.required(),
                    Validators.validLength(3),
                  ],
                ),
              ),
              SizedBox(height: 20),
              SizedBox(height: 40),
              RaisedButton(
                child: Text(
                  "Sign In",
                ),
                onPressed: () async {
                  if (_formKey.currentState.validate()) {
                    bool output = await AuthProvider()
                        .signInWithEmail(_userNameController.text, _passwordController.text);
                    if (!output) {
                      print("unsuccessful");
                    } else {
                      print("sign in successful");
                    }
                  }
                },
              ),
              RaisedButton(
                child: Text(
                  "Log in with Gmail",
                ),
                onPressed: () async {
                  bool output = await AuthProvider().signInWithGoogle();
                  if (!output) {
                    print("unsuccessful");
                  } else {
                    print("sign in successful");
                  }
                },
              ),
              RaisedButton(
                child: Text(
                  "Log in with Facebook",
                ),
                onPressed: () async {
                  bool output = await AuthProvider().signInWithFacebook();
                  if (!output) {
                    print("unsuccessful");
                  } else {
                    print("sign in successful");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

void fieldFocusChange(BuildContext context, FocusNode currentFocus, FocusNode nextFocus) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}
