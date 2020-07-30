import 'package:firebase_prac/appData/usermodel.dart';
import 'package:firebase_prac/modular_widgets/button.dart';
import 'package:firebase_prac/modular_widgets/form_decoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keyboard_avoider/keyboard_avoider.dart';
import 'package:provider/provider.dart';
import '../circle_select.dart';
import 'package:firebase_prac/appData/backend_data.dart';

class DetailsPage extends StatefulWidget {

  final String time;
  final String initVal;
  DetailsPage({this.time, this.initVal});

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  final _formKey = GlobalKey<FormState>();

  String _agendaString;
  double _height;
  final _selectedRadius = 50.0;
  final _initialRadius = 25.0;
  int circleSelected = 1;
  final trial = ['Mechanical', 'Electronics', 'Programming'];
  bool fav = false;

  void circleSelect(int field){
    setState(() {
      circleSelected = field;
    });
  }

  double sizeReturn(int n) {
    return circleSelected == n ?
    _selectedRadius : _initialRadius;
  }

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);
    final List<Function> _getters =
    [backEnd(uid: user.uid).updateMechUserData, backEnd(uid: user.uid).updateElecUserData, backEnd(uid: user.uid).updateProgUserData];

    return Scaffold(
      //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.teal[700],
        title: Text("Add an agenda"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back), color: Colors.white,
            onPressed: (){Navigator.pop(context);},
        ),

      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 30),
              Container(
                height: 106,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    SelectableCircle(
                    sizeReturn: sizeReturn, circleSelect: circleSelect, num: 1, name: "M"),
                    SelectableCircle(
                    sizeReturn: sizeReturn, circleSelect: circleSelect, num: 2, name: "E"),
                    SelectableCircle(
                    sizeReturn: sizeReturn, circleSelect: circleSelect, num: 3, name: "P"),
                  ],
                ),
              ),
              SizedBox(height: 40),
              Button(name: trial[circleSelected-1]),
              SizedBox(height: 30,),
              KeyboardAvoider(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 500),
                      height: _height,
                      color: Colors.white,
                      child: TextFormField(
                        initialValue: widget.initVal,
                        validator: (val) => val.isEmpty ? 'Enter an agenda' : null,
                        onChanged: (val) {
                          setState(() {
                            _agendaString = val;
                          });
                        },
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        decoration: FormTextDecoration.copyWith(
                          hintText: 'Add an agenda',
                        )
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 25),
              //TODO add register button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      if(_formKey.currentState.validate()){
                        await _getters[circleSelected-1](user.name, trial[circleSelected-1], widget.time, _agendaString);
                        Navigator.pop(context);
                      }
                    },
                      child: Button(name: 'Submit'),
                  ),
                  SizedBox(width: 15,),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        fav = !fav;
                      });
                    },
                      child: Icon(fav ?  Icons.star : Icons.star_border,
                      color: Colors.yellow,
                      )
                  )
                ],
              ),
            ],
          )
        ),
      ),
    );
  }
}

