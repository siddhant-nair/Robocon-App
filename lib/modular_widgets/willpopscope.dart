import 'package:firebase_prac/appData/backend_data.dart';
import 'package:flutter/material.dart';

  Future saveConfirmation(BuildContext context, items, listName, Function sumOfItems) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.teal,
        title: Text('Do you want to save your list?',
          style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text('No',
              style: TextStyle(color: Colors.white),),
          ),
          FlatButton(
            onPressed: () {
              List<dynamic> itemsFinal = items;
              itemsFinal.removeLast();
              backEnd().updateList(itemsFinal, listName, null, sumOfItems());
              Navigator.of(context).pop(true);
            },
            child: Text('Yes',
              style: TextStyle(color: Colors.white),),
          ),
        ],
      ),
    );
  }

  Future deleteConfirmation(BuildContext context, dynamic _deleterFunc, String time) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.teal,
      title: Text('Are you sure you want to delete this?',
        style: TextStyle(color: Colors.white),),
      actions: <Widget>[
        FlatButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('No',
            style: TextStyle(color: Colors.white),),
        ),
        FlatButton(
          onPressed: () {
            _deleterFunc(time);
            Navigator.of(context).pop();
          },
          child: Text('Yes',
            style: TextStyle(color: Colors.white),),
        ),
      ],
    ),
  );
}
