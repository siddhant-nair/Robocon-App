import 'package:firebase_prac/appData/usermodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DrawerDesign extends StatefulWidget {

  @override
  _DrawerDesignState createState() => _DrawerDesignState();
}

class _DrawerDesignState extends State<DrawerDesign> {


  @override
  Widget build(BuildContext context) {

  final user = Provider.of<User>(context);

    return SafeArea(
        child: Drawer(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white,
                      width: 2,
                    ),
                    color: Colors.teal[800],
                  ),
                ),
                Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 15.0, 8.0, 8.0,),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 80,
                        child: Text('${user.name}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        )),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 2),
                      child: Container(
                        color: Colors.white,
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed('/a');
                            },
                            splashColor: Colors.teal[700],
                            child: Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 20.0),
                                child: Text('Agenda',
                                    style: TextStyle(
                                      color: Colors.teal[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 3, bottom: 2),
                      child: Container(
                        color: Colors.white,
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              Navigator.of(context).pushReplacementNamed('/b');
                            },
                            splashColor: Colors.teal[700],
                            child: Container(
                              width: double.infinity,
                              color: Colors.transparent,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10.0, 20.0, 20.0, 20.0),
                                child: Text('List',
                                    style: TextStyle(
                                        color: Colors.teal[700],
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                    )),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                  ],
                )
              ],
            )
        )
    );
  }
}

