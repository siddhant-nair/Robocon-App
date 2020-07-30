import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_prac/appData/backend_data.dart';
import 'package:firebase_prac/appData/list_model.dart';
import 'package:firebase_prac/modular_widgets/forDrawer.dart';
import 'package:firebase_prac/modular_widgets/loading_screen.dart';
import 'package:firebase_prac/modular_widgets/shoppingsubpages/create_shopping_listDetails.dart';
import 'package:firebase_prac/modular_widgets/agendasubpages/animated_form.dart';
import 'package:firebase_prac/modular_widgets/shoppingsubpages/masjidLists.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MasjidList extends StatelessWidget {
  @override

  Widget build(BuildContext context) {

    return StreamProvider<List<MasjidObject>>.value(
      value: backEnd().backEndList,
      catchError: (_, __)  {
        print('error');
        return null;
      },
      child: Scaffold(
        drawer: DrawerDesign(),
            appBar: AppBar(
              title: Text('Masjid List'),
            ),
            body: MasjidListBuilder(),
            floatingActionButton: ContainerTransition(widget: CreateShoppingList()),
        ),
    );
  }
}





