import 'package:flutter/material.dart';

class SelectableCircle extends StatelessWidget {

  final Function sizeReturn;
  final Function circleSelect;
  final num;
  final name;

  SelectableCircle({this.sizeReturn, this.circleSelect, this.num, this.name});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
      circleSelect(num);
      },
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: sizeReturn(num) + 3,
        child: CircleAvatar(
          //backgroundColor: Colors.white30,
          child: Text(name, style: TextStyle(
          fontSize: sizeReturn(num),
        )),
        radius: sizeReturn(num),
        ),
      ),
    );
  }
}
