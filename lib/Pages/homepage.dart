import 'package:firebase_prac/appData/authdata.dart';
import 'package:firebase_prac/appData/backend_data.dart';
import 'package:firebase_prac/appData/usermodel.dart';
import 'package:firebase_prac/modular_widgets/forDrawer.dart';
import 'file:///D:/AndroidStudioProjects/firebase_prac/lib/modular_widgets/agendasubpages/FAB_form.dart';
import 'file:///D:/AndroidStudioProjects/firebase_prac/lib/modular_widgets/agendasubpages/agenda_list.dart';
import 'file:///D:/AndroidStudioProjects/firebase_prac/lib/modular_widgets/agendasubpages/animated_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final signOut = AuthService();

  Widget tabText(String name){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text('$name'),
    );
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    var data;
    if(user != null) {
      data = backEnd(uid: user.uid);
    }


    return user == null ? Container() : DefaultTabController(
          length: 3,
          child: Scaffold(
            drawer: DrawerDesign(),
            backgroundColor: Colors.white12,
            appBar: AppBar(
              title: Text('Robocon'),
              actions: <Widget>[
                GestureDetector(
                  onTap: () {
                    signOut.signingOut();
                    Navigator.of(context).pushReplacementNamed('/c');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Icon(Icons.exit_to_app)
                    ),
                  )
                )
              ],
              bottom: TabBar(
                tabs: <Widget>[
                  tabText('Mechanical'),
                  tabText('Electronics'),
                  tabText('Programming'),
                ],
              ),
            ),
            body: TabBarView(
              children: <Widget>[
                AgendaList(data.backEndDataM, data.deleteMechDoc),
                AgendaList(data.backEndDataE, data.deleteElecDoc),
                AgendaList(data.backEndDataP, data.deleteProgDoc),
              ],
            ),
            floatingActionButton: ContainerTransition(widget: DetailsPage()),
          ),
        );

  }
}

/*floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.teal,
            onPressed: () async {
              await backEnd(uid: user.uid).updateUserData('name ','field test','agenda test');
            },
          ),*/
