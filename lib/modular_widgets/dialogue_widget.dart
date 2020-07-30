import 'package:flutter/material.dart';

class DialogueBox extends StatelessWidget {

  final title;
  DialogueBox({this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: SimpleDialog(
              backgroundColor: Colors.teal,
              title: Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  "$title",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
              children: <Widget>[
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(right: 30.0),
                        child: Text('Retry',
                          style:
                          Theme.of(context).textTheme.button,
                ),
              )
            ]
          )
        ],
      ),
    );
  }
}

