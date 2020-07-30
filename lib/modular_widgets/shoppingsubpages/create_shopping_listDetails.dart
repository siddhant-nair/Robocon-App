import 'package:firebase_prac/appData/backend_data.dart';
import 'package:firebase_prac/modular_widgets/willpopscope.dart';
import 'package:intl/intl.dart';
import 'package:firebase_prac/modular_widgets/form_decoration.dart';
import 'package:flutter/material.dart';

class CreateShoppingList extends StatefulWidget{

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<CreateShoppingList> {

  String listName = 'Masjid List ${DateFormat('dd-MM').format(DateTime.now())}';

  List<Map> items = [{'item': '', 'price': 0}, {'item': '', 'price': 0}];
  int sumOfItems(){
    int sum = 0;
    for(var i = 0 ; i < items.length ; i++){
      sum += items[i]['price'];
    }
    return sum;
  }

  Future<bool> _onWillPop() async {
    return (await saveConfirmation(context, items, listName, sumOfItems)) ?? false;
  }

  @override
  Widget build(BuildContext context) {

    bool keyboardIsOpen = MediaQuery.of(context).viewInsets.bottom != 0.0;

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          title: SizedBox(
            width: 200,
            child: TextFormField(
              initialValue: listName,
              decoration: InputDecoration(
                hintText: 'Enter List name',
              ),
              style: Theme.of(context).primaryTextTheme.headline6,
              onChanged: (val){
                {setState(() => listName = val);}
              },
            ),
          ),
          leading: IconButton(
            onPressed: () async {
              List<dynamic> itemsFinal = items;
              itemsFinal.removeLast();
              await backEnd().updateList(itemsFinal, listName, null, sumOfItems());
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)
          ),
        ),
        body: ListView.builder(
                shrinkWrap: true,
                itemCount: items.length,
                itemBuilder: (context, index) {

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.5),
                    child: Container(
                      child: TextFormField(
                        onEditingComplete: (){
                          if(index == items.length - 2){
                            setState(() {
                              items.add({'item' : '', 'price': 0});
                            });
                          }
                           FocusScope.of(context).nextFocus();
                        },
                        onTap: (){
                            if(index == items.length - 1){
                              setState(() {
                                items.add({'item' : '', 'price': 0});
                              });
                            }
                          },
                          autofocus: true,
                          onChanged: (String val){
                            setState(() => items[index]['item'] = val);
                            },
                          decoration: index == items.length - 1 ? null : listDecoration,
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                          initialValue: items[index]['item'],
                        ),
                      //),
                    ),
                  );
              }
            ),
        floatingActionButton: keyboardIsOpen ? null : FloatingActionButton(
            child: Icon(Icons.check,
                color: Colors.white,
                size: 30
            ),
            backgroundColor: Colors.teal[700],
            onPressed: () async {
              List<dynamic> itemsFinal = items;
              itemsFinal.removeAt(items.length - 1);
              await backEnd().updateList(itemsFinal, listName, null, sumOfItems());
              Navigator.pop(context);
            }),
      ),
    );
  }
}
