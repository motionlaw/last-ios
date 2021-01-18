import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../models/cases.dart';

class CaseRowItem extends StatelessWidget {
  const CaseRowItem({
    this.index,
    this.cases,
    this.lastItem,
  });

  final Cases cases;
  final int index;
  final bool lastItem;

  @override
  Widget build(BuildContext context) {
    final row = SafeArea(
        child: ExpansionTile(
      leading: Icon(Icons.folder_outlined),
      title: Text(
        "D1002-20 Franklin Eduardo Araniva Pastora",
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        'Deportation Immigration',
        style: TextStyle(
          fontSize: 12.0,
        ),
      ),
      children: <Widget>[
        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          dense: true,
          title: Row(
            children: <Widget>[
              SizedBox(
                width: 55,
              ),
              Text('ADDED:',
                  style:
                      TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)),
              Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Text('Dec 7,2019 by Claire Esquivel',
                    style: TextStyle(
                      fontSize: 13.0,
                    )),
              ),
            ],
          ),
        ),
        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          dense: true,
          title: Row(
            children: <Widget>[
              SizedBox(
                width: 55,
              ),
              Text('STATUS UPDATE:',
                  style:
                      TextStyle(fontSize: 13.0, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          dense: true,
          title: Row(
            children: <Widget>[
              SizedBox(
                width: 55,
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Text(
                    "NJ sent email to ICE officer reg. Franklin's possible mental illness. Waiting on response. Franklin can be deported any day- he was ordered removed. He asked for deportation when he found out his hearing was going to be continued.",
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.justify,
                    maxLines: 5,
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          dense: true,
          title: Row(
            children: <Widget>[
              SizedBox(
                width: 55,
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: Text("Add new update",
                      style: TextStyle(
                          fontSize: 10.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue),
                      textAlign: TextAlign.right),
                ),
              ),
            ],
          ),
        )
      ],
    ));

    if (lastItem) {
      return row;
    }

    return Column(
      children: <Widget>[
        row,
        Padding(
          padding: const EdgeInsets.only(
            left: 100,
            right: 16,
          ),
          child: Container(
            height: 1,
            color: Colors.amber,
          ),
        ),
      ],
    );
  }
}
