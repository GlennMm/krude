import 'package:flutter/material.dart';
import 'Views/Forms/LoginForm.dart';

class LogIn extends StatefulWidget {
  LogIn({Key key}) : super(key: key);

  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {

  @override
  Widget build(BuildContext context) {
    return LoginForm();
  }
}
