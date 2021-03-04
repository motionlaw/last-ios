import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import '../../style/theme.dart' as Theme;

Future<http.Response> _asyncMethod() async {
  var box = await Hive.openBox('app_data');
  final _responseFuture = await http
      .get('https://qqv.oex.mybluehost.me/api/cases', headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${box.get('token')}'
  });
  return _responseFuture;
}

class PaymentPage extends StatelessWidget {
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
        middle: Text('Payments'),
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
          ])
        )
      )
    ));
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
      initiallyExpanded: true,
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
              Text('CASE BILLING INFORMATION:',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          dense: true,
          title: Row(
            children: <Widget>[
              SizedBox(
                width: 50,
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.70,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Number')),
                      DataColumn(label: Text('Total')),
                      DataColumn(label: Text('Status'))
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('00252')),
                        DataCell(Text('\$2.000,00')),
                        DataCell(Icon(CupertinoIcons.checkmark_square,
                            color: Colors.green))
                      ]),
                      DataRow(cells: [
                        DataCell(Text('00113')),
                        DataCell(Text('\$3.000,00')),
                        DataCell(
                            Icon(CupertinoIcons.creditcard,
                                color: Colors.blue), onTap: () {
                          _launchURL();
                        })
                      ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

_launchURL() async {
  const url = 'https://motion-law.mycase.com/xa7n7str';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
