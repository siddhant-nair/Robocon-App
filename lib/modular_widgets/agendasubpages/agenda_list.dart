import 'package:animations/animations.dart';
import 'package:firebase_prac/appData/backend_data.dart';
import 'package:firebase_prac/appData/userdata_model.dart';
import 'package:firebase_prac/appData/usermodel.dart';
import 'package:firebase_prac/modular_widgets/agendasubpages/FAB_form.dart';
import 'package:firebase_prac/modular_widgets/willpopscope.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AgendaList extends StatelessWidget {

  final _getterFunc;
  final _deleterFunc;
  AgendaList(this._getterFunc, this._deleterFunc);

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return StreamBuilder<List<AgendaObject>>(
          stream: _getterFunc,
            builder: (context, snapshot) {
              dynamic agendaData = snapshot.data;
              return agendaData == null ? Container() : ListView.builder(
                  itemCount: agendaData.length,
                  itemBuilder: (context, index) {
                    return OpenContainer(
                        openColor: Colors.white12,
                        closedColor: Colors.white12,
                        closedShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)
                        ),
                      openBuilder: (context, closeContainer) =>
                          DetailsPage(time: agendaData[index].time, initVal: agendaData[index].agenda),
                      closedBuilder: (context, openContainer){
                        return InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: () => openContainer(),
                          onLongPress: () async {
                          return await deleteConfirmation(context, _deleterFunc, agendaData[index].time);
                          //_deleterFunc(agendaData[index].time);
                        },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                            child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: Colors.white,
                              width: 2,
                              ),
                              color: Colors.teal[800],
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(agendaData[index].agenda,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white
                                  )
                                  ),
                                  SizedBox(height: 10,),
                                  Text('${agendaData[index].name}',
                                  style: TextStyle(
                                      color: Colors.white
                                  ),),
                                ],
                              ),
                            ),
                      ),
                          ),
                        );}
                    );
          }
        );
      }
    );
  }
}
     /*StreamProvider<List<AgendaObject>>.value(
        value: backEnd().backEndDataM,
        builder: (context, snapshot) {

        final agendaData = Provider.of<List<AgendaObject>>(context);*/
