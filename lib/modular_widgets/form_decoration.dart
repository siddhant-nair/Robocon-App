import 'package:flutter/material.dart';

dynamic FormTextDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(25),
      borderSide: BorderSide(
        color: Colors.white,
        width: 3,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.tealAccent,
        width: 3,
      ),
    ),
  );

dynamic listDecoration = InputDecoration(
    enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.teal[700],
            style: BorderStyle.solid
        )
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.teal[700],
            style: BorderStyle.solid
        )
      )
  );

