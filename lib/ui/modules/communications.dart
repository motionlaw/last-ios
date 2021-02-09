import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

Future<http.Response> _asyncMethod() async {
  var box = await Hive.openBox('app_data');
  final _responseFuture = await http
      .get('https://qqv.oex.mybluehost.me/api/cases', headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${box.get('token')}'
  });
  return _responseFuture;
}

class CommunicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Communication'),
        ),
        child: Scaffold(
            body: SafeArea(
                child: Column(children: <Widget>[
          new FutureBuilder(
              future: _asyncMethod(),
              builder: (BuildContext context, AsyncSnapshot response) {
                if (!response.hasData) {
                  return Align(
                      alignment: Alignment.bottomLeft,
                      child: new Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: new Center(
                          child: new CupertinoActivityIndicator(),
                        ),
                      ));
                }
                List<dynamic> jsonList = json.decode(response.data.body);
                return new MyExpansionTileList(jsonList);
              })
        ]))));
  }
}

class MyExpansionTileList extends StatelessWidget {
  final List<dynamic> elementList;

  MyExpansionTileList(this.elementList);

  List<Widget> _getChildren() {
    List<Widget> children = [];
    elementList.forEach((element) {
      if ( children.length < 3 ){
        children.add(
          new MyExpansionTile(element['id'], element['name'], element['practice_area']),
        );
      }
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return new ListView(
      shrinkWrap: true,
      children: _getChildren(),
    );
  }
}

class MyExpansionTile extends StatefulWidget {
  String id;
  String name;
  String practice_area;
  MyExpansionTile(this.id, this.name, this.practice_area);
  @override
  State createState() => new MyExpansionTileState(this.id, this.name, this.practice_area);
}

class MyExpansionTileState extends State<MyExpansionTile> {
  String id;
  String name;
  String practice_area;
  MyExpansionTileState(this.id, this.name, this.practice_area);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new ExpansionTile(
      leading: Icon(CupertinoIcons.bag),
      title: Text(
        widget.name,
        style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        widget.practice_area,
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
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/casesDetailed',
                            arguments: {'myData': 'Some String Data'});
                      },
                      child: new Text("See more",
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.blue),
                          textAlign: TextAlign.right),
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
