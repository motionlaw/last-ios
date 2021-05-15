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
      .get(Uri.parse('https://qqv.oex.mybluehost.me/api/cases'), headers: <String, String>{
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
        middle: Text('Make a payment', style: TextStyle(
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
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if ( snapshot.connectionState == ConnectionState.waiting ) {
                  return Align(
                      alignment: Alignment.bottomLeft,
                      child: new Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: new Center(
                          child: new CupertinoActivityIndicator(),
                        ),
                      ));
                } else if ( snapshot.hasError ) {
                  return Text('Error');
                } else {
                  List<dynamic> jsonList = json.decode(snapshot.data.body);
                  if ( jsonList.length > 0 ) {
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
                }
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
              Text('CASE BILLING INFORMATION',
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
              width: 55,
            ),
            Text('Select an Invoice to Pay:',
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 13.0,
                    fontWeight: FontWeight.bold)),
          ])
        ),
        ListTile(
          visualDensity: VisualDensity(horizontal: 0, vertical: -4),
          dense: true,
          title: Row(
            children: <Widget>[
              SizedBox(
                width: 30,
              ),
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text('Number')),
                      DataColumn(
                          label: Expanded(
                            child: Text(
                              'Total',
                              textAlign: TextAlign.center,
                            )
                          )
                      ),
                      DataColumn(
                        label: Expanded(
                        child: Text(
                          'Status',
                          textAlign: TextAlign.center,
                        ))
                      )
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('00252')),
                        DataCell(Text('\$2.000,00')),
                        DataCell(
                          Container(
                            width: 60,
                            height:40,
                            child: Icon(CupertinoIcons.checkmark_square,
                                color: Colors.green)
                          )
                        )
                      ]),
                      DataRow(cells: [
                        DataCell(Text('00113')),
                        DataCell(Text('\$3.000,00')),
                        DataCell(
                          new GestureDetector(
                            onTap: (){
                              _launchURL();
                            },
                          child: Container(
                              width: 60,
                              height:40,
                              child: Icon(CupertinoIcons.creditcard,
                                  color: Colors.red)
                          ))
                        )
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
