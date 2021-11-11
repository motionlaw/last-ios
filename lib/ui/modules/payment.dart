import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:motionlaw/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../style/theme.dart' as Theme;
import '../../utils/constants.dart' as constants;

Future<http.Response> _asyncMethod() async {
  var box = await Hive.openBox('app_data');
  final _responseFuture = await http
      .get(Uri.parse('${constants.API_BACK_URL}/api/cases'), headers: <String, String>{
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
        middle: Text(Translate.of(context).make_payment, style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Theme.Colors.loginGradientButton,
        previousPageTitle: Translate.of(context).back
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
                  final body = json.decode(snapshot.data.body);
                  if ( body['cases'] != false ) {
                    List<dynamic> jsonList = body['cases'];
                    if ( jsonList.length > 0 ) {
                      return new MyExpansionTileList(jsonList);
                    } else {
                      return ExpansionTile(
                        leading: Icon(CupertinoIcons.drop_triangle),
                        trailing: SizedBox.shrink(),
                        title: Text(
                          Translate.of(context).no_cases,
                          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  } else {
                    return ExpansionTile(
                      leading: Icon(CupertinoIcons.drop_triangle),
                      trailing: SizedBox.shrink(),
                      title: Text(
                        Translate.of(context).no_cases,
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
          new MyExpansionTile(element['id'], element['name'], element['practice_area'], element['invoices']),
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
  var invoices;
  MyExpansionTile(this.id, this.name, this.practice_area, this.invoices);
  @override
  State createState() => new MyExpansionTileState(this.id, this.name, this.practice_area, this.invoices);
}

class MyExpansionTileState extends State<MyExpansionTile> {
  String id;
  String name;
  String practice_area;
  var invoices;
  MyExpansionTileState(this.id, this.name, this.practice_area, this.invoices);

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
              Text(Translate.of(context).case_billing_information,
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
            Text(Translate.of(context).select_invoice,
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
              (widget.invoices.length > 0) ?
              Padding(
                padding: EdgeInsets.all(0.0),
                child: Container(
                  alignment: Alignment.centerLeft,
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: DataTable(
                    columns: [
                      DataColumn(label: Text(Translate.of(context).number)),
                      DataColumn(
                          label: Expanded(
                            child: Text(
                              Translate.of(context).total,
                              textAlign: TextAlign.center,
                            )
                          )
                      ),
                      DataColumn(
                        label: Expanded(
                        child: Text(
                          Translate.of(context).status,
                          textAlign: TextAlign.center,
                        ))
                      )
                    ],
                    rows: [
                      for(var item in widget.invoices )
                        DataRow(cells: [
                          DataCell(Text(item['number'])),
                          DataCell(Text(item['total_amount'])),
                          DataCell(
                              Container(
                                  width: 60,
                                  height:40,
                                  child: (item['paid'] == true ) ? Icon(CupertinoIcons.checkmark_square,
                                      color: Colors.green)
                                      : Icon(CupertinoIcons.creditcard,
                                      color: Colors.red)
                              )
                          )
                        ])
                    ],
                  ),
                ),
              ) : Row(
                    children: <Widget>[
                      SizedBox(
                        width: 25,
                      ),
                      Text(Translate.of(context).no_available_billings,
                      style: TextStyle(
                      color: Colors.blue,
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold)),
                    ],
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
