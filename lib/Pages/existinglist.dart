import 'package:firebase_prac/appData/backend_data.dart';
import 'package:firebase_prac/appData/list_model.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:firebase_prac/modular_widgets/form_decoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';

class ShoppingList extends StatefulWidget{

  final MasjidObject listObject;
  ShoppingList(this.listObject);

  @override
  _ShoppingListState createState() => _ShoppingListState();
}

class _ShoppingListState extends State<ShoppingList> {

  String listName;

  @override
  Widget build(BuildContext context) {

    List items = widget.listObject.items;
    String editListName = listName == null ? widget.listObject.listName : listName;

    int sumOfItems(){
      int sum = 0;
      for(var i = 0 ; i < items.length ; i++){
        sum += items[i]['price'];
      }
      return sum;
    }

    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          width: 200,
          child: TextFormField(
            initialValue: widget.listObject.listName,
            decoration: InputDecoration(
              hintText: 'Enter List name',
            ),
            style: Theme.of(context).primaryTextTheme.headline6,
            onChanged: (val){
              setState(() {
                listName = val;
              });
            },
          ),
        ),
        leading: IconButton(
            onPressed: () async {
              await backEnd().updateList(items,
                  editListName,
                  widget.listObject.time,
                  sumOfItems());
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back)
        ),
        actions: <Widget>[
          Center(child: Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: Text("Total Amt. ${sumOfItems()}"),
          ))
        ],
      ),
      floatingActionButton: Ink(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 3.0),
                color: Colors.teal[700],
                shape: BoxShape.circle,
                ),
                  child: FloatingActionButton(
                    elevation: 0.0,
                    onPressed: () => setState(() {items.add({'item' : '', 'price': 0});}),
                    backgroundColor: Colors.white,
                      child: Icon(Icons.add, color: Colors.teal[700],
                      size: 40),
                ),
              ),
      body: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {

            TextEditingController _controller = TextEditingController();
            _controller.value = _controller.value.copyWith(
              text: items[index]['item'],
              selection: TextSelection(baseOffset: items[index]['item'].length, extentOffset: items[index]['item'].length),
              composing: TextRange.empty,
            );

            return Padding(
              padding: EdgeInsets.symmetric(vertical: 3.5),
              child: Slidable(
                actionPane: SlidableDrawerActionPane(),
                actionExtentRatio: 0.25,
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: () {
                      setState(() {
                        items.removeAt(index);
                        backEnd().updateList(items,
                          editListName,
                          widget.listObject.time,
                          sumOfItems());
                      });
                    },
                  ),
                ],
                child: Container(
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          controller: _controller,
                          onChanged: (String val){
                            setState(() => items[index]['item'] = val);
                          },
                          decoration: listDecoration,
                          style: Theme.of(context).primaryTextTheme.bodyText1,
                        ),
                      ),
                      SizedBox(width: 5,),
                      Stack(
                        children: <Widget>[
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                              onEditingComplete: (){
                                backEnd().updateList(items,
                                    editListName,
                                    widget.listObject.time,
                                    sumOfItems());
                                FocusScope.of(context).unfocus();
                              },
                              onChanged: (val){
                                setState(() {
                                  int price = int.parse(val);
                                  items[index]['price'] = price;
                                  sumOfItems();
                                });
                              },
                              decoration: listDecoration,
                              style: Theme.of(context).primaryTextTheme.bodyText1,
                              initialValue: items[index]['price'].toString()
                                  != '0' ? items[index]['price'].toString() : null,
                            ),
                          ),
                          Positioned(
                            top: 17.5,
                            right: 18,
                            child: Text('/-',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                              ),),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      ),
    );
  }
}
