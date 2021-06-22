import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../style/theme.dart' as Theme;

Future<http.Response> _asyncMethod() async {
  var box = await Hive.openBox('app_data');
  final _responseFuture = await http
      .get(Uri.parse('https://qqv.oex.mybluehost.me/api/cases'), headers: <String, String>{
    'Accept': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${box.get('token')}'
  });
  return _responseFuture;
}

class CommunicationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/chat');
            },
            backgroundColor: Theme.Colors.loginGradientButton,
            child: Icon(
              CupertinoIcons.chat_bubble_2,
            ),
        ),
        body : CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Text('Your Cases', style: TextStyle(
              color: Colors.white,
            ),),
            backgroundColor: Theme.Colors.loginGradientButton,
            previousPageTitle: 'Back'
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
                if (  jsonList.length > 0 ){
                  return new MyExpansionTileList(jsonList);
                } else {
                  return ExpansionTile(
                    leading: Icon(CupertinoIcons.drop_triangle),
                    trailing: SizedBox.shrink(),
                    title: Text(
                      'There are not cases linked to your user',
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                    ),
                  );
                }

              })
        ])))));
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
          new MyExpansionTile(element['id'], element['name'], element['practice_area'], element['created_at'], element['attorney']),
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
  String created_at;
  String attorney;
  MyExpansionTile(this.id, this.name, this.practice_area, this.created_at, this.attorney);
  @override
  State createState() => new MyExpansionTileState(this.id, this.name, this.practice_area, this.created_at, this.attorney);
}

class MyExpansionTileState extends State<MyExpansionTile> {
  String id;
  String name;
  String practice_area;
  String created_at;
  String attorney;
  MyExpansionTileState(this.id, this.name, this.practice_area, this.created_at, this.attorney);

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
                child: Text('${widget.created_at} by ${widget.attorney}',
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
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Container(
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: new GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/casesDetailed',
                            arguments: {
                              'path': widget.name,
                              'practice_area': widget.practice_area,
                              'created_at': widget.created_at,
                              'attorney': widget.attorney
                          }
                        );
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
