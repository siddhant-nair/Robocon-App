import 'package:firebase_prac/Pages/Auth_Pages/sign_in.dart';
import 'package:flutter/material.dart';

import 'Auth_Pages/register.dart';

class Authentication extends StatefulWidget {
  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool page = true;
  void pageSwitch() {
    setState((){page = !page;});
  }

  @override
  Widget build(BuildContext context) {

    return
      page ? SignIn(pageSwitch: pageSwitch) : Register(pageSwitch: pageSwitch);
  }
}
