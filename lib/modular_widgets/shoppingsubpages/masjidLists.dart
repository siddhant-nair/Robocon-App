import 'package:animations/animations.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_prac/Pages/existinglist.dart';
import 'package:firebase_prac/appData/list_model.dart';
import 'package:firebase_prac/appData/userdata_model.dart';
import 'package:firebase_prac/modular_widgets/willpopscope.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_prac/appData/backend_data.dart';

class MasjidListBuilder extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final lists = Provider.of<List<MasjidObject>>(context);

    return lists == null ? Container() : SingleChildScrollView(
          child: ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            reverse: true,
              itemCount: lists.length,
              itemBuilder: (context, index)
            {
              return OpenContainer(
                openColor: Colors.white12,
                closedColor: Colors.white12,
                closedShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                ),
                openBuilder: (context, closeBuilder) => ShoppingList(lists[index]),
                closedBuilder: (context, openBuilder) {
                return Container(
                  child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 2),
                    child: InkWell(
                      enableFeedback: false,
                      splashColor: Theme
                        .of(context)
                        .primaryColor,
                      borderRadius: BorderRadius.circular(20),
                      onLongPress: () async {
                        return await deleteConfirmation(context, backEnd().deleteListDoc, lists[index].time);
                        backEnd().deleteListDoc(lists[index].time);
                      },
                      onTap: () {
                      openBuilder();
                    },
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
                              Text(lists[index].listName,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white
                                  )
                              ),
                              SizedBox(height: 10,),
                              Row(
                                children: <Widget>[
                                  Text('Items: ${lists[index].items.length}',
                                    style: TextStyle(
                                        color: Colors.white
                                       ),
                                     ),
                                  SizedBox(width: 20),
                                  Text('Total: '
                                      '${lists[index].total == 0 ? 'Pending Trip' : lists[index].total}',
                                    style: TextStyle(
                                        color: Colors.white
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              );
            }
          );
        }
      ),
    );
  }
}

/**/

