import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final String name;

  Button({this.name}) ;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: Container(
            decoration: BoxDecoration(
              color: Colors.teal[700],
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white,
                width: 2.5,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(12),
              child: Text('$name',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18.0,
                  )
              ),
            )
        ),
      ),
    );
  }
}

