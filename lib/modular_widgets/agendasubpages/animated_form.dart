import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContainerTransition extends StatelessWidget {

  final Widget widget;
  ContainerTransition({this.widget});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fadeThrough,
      transitionDuration: Duration(milliseconds: 500),
      openColor: Colors.blueGrey[900],
      closedElevation: 5.0,
      closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100)
      ),
      closedColor: Colors.white,
      //tappable: true,
      openBuilder: (context, closeContainer){
      return widget;
      },
      closedBuilder: (context , openContainer){
      return Ink(
          decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 3.0),
        color: Colors.white,
        shape: BoxShape.circle,
          ),
        child: FloatingActionButton(
          elevation: 0.0,
          onPressed: openContainer,
          backgroundColor: Colors.teal[700],
          child: Icon(Icons.add, color: Colors.white,),
          ),
        );
      },
    );
  }
}


/*
Navigator.of(context).push(
MaterialPageRoute<void>(
builder: (BuildContext context) {
return OpenContainer(
transitionDuration: Duration(milliseconds: 300),
tappable: true,
openBuilder: (BuildContext c, VoidCallback action) => Center(
child: Container(child: SafeArea(child: Text('testing')))),
closedBuilder: (BuildContext c, VoidCallback action) => Text("Click Me"),
);
},
),
);*/
