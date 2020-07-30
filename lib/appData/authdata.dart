import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_prac/appData/backend_data.dart';
import 'package:firebase_prac/appData/usermodel.dart';
import 'package:flutter/material.dart';

class AuthService{


  final FirebaseAuth _auth = FirebaseAuth.instance;

  User parseUser(FirebaseUser user){
    User userId = user != null ? User(uid: user.uid, name: user.displayName) : null;
    return userId;
  }

  //stream function
  Stream<User> get user{
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => parseUser(user));
  }
  
  //sign in anon
  Future anonSignIn() async {
    try{
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    }catch(e){
      print(e.toString());
      return null;
    }
  }

  //sign in w/ email and pass
  Future signInWithEmailAndPass(String email, String pass) async {
    try{
      AuthResult result =
        await _auth.signInWithEmailAndPassword(email: email, password: pass);
      FirebaseUser user = result.user;
      return parseUser(user);
    }catch(e){
      print(e.toString());
    }
  }

  //sign in with google
  /*Future signInGoogle() async {
    try{
     AuthResult result =
      await _auth.
    }catch{

    }
  }*/

  //register
  Future regWithEmailAndPass(String email, String pass, String firstName, String lastName) async {
    try{
      AuthResult result =
          await _auth.createUserWithEmailAndPassword(email: email, password: pass);
      backEnd(uid: result.user.uid); //.updateUserData('name', 'field', 'agenda1');
      FirebaseUser user = result.user;
      UserUpdateInfo updateInfo = UserUpdateInfo();
      updateInfo.displayName = '$firstName $lastName';
      await user.updateProfile(updateInfo);
      return parseUser(user);
    }catch(e){
      print(e.toString());
      return null;
    }
  }


  //sign out
  Future signingOut() async {
    try{
      return await _auth.signOut();
    }catch(e){
      print(e.toString());
      SnackBar(
        content: Text('Couldn\'t sign out' )
      );
    }
  }
}