import 'package:firebase_prac/modular_widgets/button.dart';
import 'package:firebase_prac/modular_widgets/dialogue_widget.dart';
import 'package:firebase_prac/modular_widgets/form_decoration.dart';
import 'package:firebase_prac/modular_widgets/loading_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_prac/appData/authdata.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class SignIn extends StatefulWidget {

  final Function pageSwitch;
  SignIn({this.pageSwitch});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email;
  String password;
  bool showText = true;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      appBar: AppBar(
        title: Text('Sign-in page')
      ),
      body: Form(
          key: _formKey,
          child: KeyboardAvoider(
            autoScroll: true,
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children:<Widget>[
                  SizedBox(height: 135),
                  TextFormField(
                    inputFormatters: [BlacklistingTextInputFormatter(RegExp('[ ]'))],
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) => val.isEmpty ? 'Enter an Email ID' : null,
                    decoration: FormTextDecoration.copyWith(hintText: 'Email ID' ),
                    onChanged: (val) {
                      setState(() {email = val;});
                    },
                  ),
                  SizedBox(height: 40),
                  TextFormField(
                    validator: (val) => val.isEmpty ? 'Password is required' : null,
                    decoration: FormTextDecoration.copyWith(
                      hintText: 'Password',
                      suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              showText = !showText;
                            });
                          },
                          child: showText ?
                          Icon(CupertinoIcons.eye_solid) : Icon(CupertinoIcons.eye)
                      )
                    ),
                    obscureText: showText,

                    onChanged: (val) {
                      setState(() {password = val;});
                    },
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () async {
                          if(_formKey.currentState.validate()){
                            Navigator.push(context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) => LoadingScreen(),
                                )
                            );
                          dynamic result =
                            await _auth.signInWithEmailAndPass(email, password);
                            Navigator.of(context).popAndPushNamed('/a');
                          if(result == null){
                            showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return DialogueBox(title:
                              'username or password is invalid');
                              }
                            );
                          }
                          }
                        },
                        child: Button(name: 'Sign In')
                      ),
                      Text('or',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      )),
                      GestureDetector(
                          onTap: () {
                            widget.pageSwitch();
                          },
                        child: Button(name: 'Register')),
                    ],
                ),
              ]
            ),
        ),
          ),
      ),
    );
  }
}
