import 'package:firebase_prac/modular_widgets/button.dart';
import 'package:firebase_prac/modular_widgets/dialogue_widget.dart';
import 'package:firebase_prac/modular_widgets/form_decoration.dart';
import 'package:firebase_prac/modular_widgets/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_prac/appData/authdata.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';


class Register extends StatefulWidget {

  final Function pageSwitch;
  Register({this.pageSwitch});


  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  String email;
  String firstName;
  String lastName;
  String password;
  String passConfirm;

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
          title: Text('Sign-Up page'),
          actions: <Widget>[
            SizedBox(width: 8),
            InkWell(
              customBorder: ShapeBorder.lerp(
                  CircleBorder(/*side: BorderSide(width: 0)*/),
                  null, 0),
              splashColor: Colors.deepOrange,
              onTap: () {
                widget.pageSwitch();
              },
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Container(
                    child: Text('Sign-In'),
                  ),
                ),
              ),
            ),
          ],
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: SingleChildScrollView(
            child: Column(
                children:<Widget>[

                  //Email Field

                  TextFormField(
                    inputFormatters: [BlacklistingTextInputFormatter(RegExp('[ ]'))],
                    validator: (val) => val.isEmpty ? 'Enter an Email ID' : null,
                    decoration: FormTextDecoration.copyWith(hintText: 'Email ID'),
                    onEditingComplete: (){
                      FocusScope.of(context).nextFocus();
                    },
                    onChanged: (val) {
                      setState(() {email = val;});
                    },
                  ),
                  SizedBox(height: 18),

                  //Name Fields

                  Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter First Name' : null,
                          decoration: FormTextDecoration.copyWith(hintText: 'First Name'),
                          onEditingComplete: (){
                            FocusScope.of(context).nextFocus();
                          },
                          onChanged: (val) {
                            setState(() {firstName = val;});
                          },
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: TextFormField(
                          validator: (val) => val.isEmpty ? 'Enter Last Name' : null,
                          decoration: FormTextDecoration.copyWith(hintText: 'Last Name'),
                          onEditingComplete: (){
                            FocusScope.of(context).nextFocus();
                          },
                          onChanged: (val) {
                            setState(() {lastName = val;});
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 18),

                  //Password field

                  TextFormField(
                    validator:
                        (val) => val.length < 8 ? 'Password is too short' : null,
                    decoration: FormTextDecoration.copyWith(hintText: 'Password'),
                    obscureText: true,
                    onEditingComplete: (){
                      FocusScope.of(context).nextFocus();
                    },
                    onChanged: (val) {
                      setState(() {password = val;});
                    },
                  ),
                  SizedBox(height: 18),

                  //Confirm password field

                  TextFormField(
                    validator:
                        (val) => val != password ? 'Passwords do not match' : null,
                    decoration: FormTextDecoration.copyWith(hintText: 'Confirm Password'),
                    obscureText: true,
                    onEditingComplete: (){
                      FocusScope.of(context).nextFocus();
                    },
                    onChanged: (val) {
                      setState(() {passConfirm = val;});
                    },
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                                await _auth.regWithEmailAndPass(email, password, firstName, lastName);
                              Navigator.of(context).popAndPushNamed('/a');
                              if(result == null){
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context){
                                    return DialogueBox(title:
                                            'username entered is invalid',);
                                  }
                                );
                              }
                            }
                          },
                          child: Button(name: 'Register')
                    ),
                  ],
                )
              ]
            ),
          ),
        ),
      ),
    );
  }
}
