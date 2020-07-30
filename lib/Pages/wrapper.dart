import 'package:firebase_prac/Pages/Auth.dart';
import 'package:firebase_prac/Pages/homepage.dart';
import 'package:firebase_prac/appData/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return user == null ? Authentication() : HomePage();
  }
}
