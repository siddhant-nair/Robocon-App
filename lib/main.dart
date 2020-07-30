import 'package:firebase_prac/Pages/Auth.dart';
import 'package:firebase_prac/Pages/Auth_Pages/register.dart';
import 'package:firebase_prac/Pages/JunctionPage.dart';
import 'package:firebase_prac/Pages/homepage.dart';
import 'package:firebase_prac/Pages/shopping_list_page.dart';
import 'package:firebase_prac/Pages/wrapper.dart';
import 'package:firebase_prac/appData/authdata.dart';
import 'package:firebase_prac/appData/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';


void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent)
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {



    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryTextTheme: TextTheme(
            bodyText1: TextStyle(
              color: Colors.white,
              fontSize: 14
            )
          ),
          textTheme: TextTheme(
            button: TextStyle(
              color: Colors.white70,
              fontSize: 18,
            )
          ),
          scaffoldBackgroundColor: Colors.blueGrey[900],
          primaryColor: Colors.teal[800],
          primarySwatch: Colors.teal,
          accentColor: Colors.white,
        ),
        home: Wrapper(),
        routes: <String, WidgetBuilder> {
        '/a': (BuildContext context) => HomePage(),
        '/b': (BuildContext context) => MasjidList(),
        '/c': (BuildContext context) => Authentication(),
      },
      ),
    );
  }
}


