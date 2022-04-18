import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
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
      print('JD : ${element}');
      if ( children.length < 3 ){
        children.add(
          new MyExpansionTile(elementList),
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
  final List<dynamic> elementList;
  MyExpansionTile(this.elementList);
  @override
  State createState() => new MyExpansionTileState(elementList);
}

class MyExpansionTileState extends State<MyExpansionTile> {
  final List<dynamic> elementList;
  MyExpansionTileState(this.elementList);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('Diego ${elementList}');
    DateFormat dateFormat = DateFormat("MMM d, yyyy");
    return Container(
        child: Column(
            children: <Widget>[
              Container(
                color: Colors.black12,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15
                  ),
                  child: Text(Translate.of(context).case_information, style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                width: MediaQuery.of(context).size.width,
                height: 30,
              ),
              Container(
                alignment: Alignment.centerLeft,
                margin: EdgeInsets.only(
                  top: 10,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 15,
                  ),
                  child: RichText(
                      text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: '${Translate.of(context).name}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            TextSpan(text: elementList[0]['name'], style: TextStyle(
                                color: Colors.black54
                            ),)
                          ])),
                ),
                width: MediaQuery.of(context).size.width,
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 15
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(text: '${Translate.of(context).added}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: dateFormat.format(DateTime.parse(elementList[0]['created_at'])) + ' by ' + elementList[0]['attorney'], style: TextStyle(
                              color: Colors.black54
                          )),
                        ],
                      ),
                    )
                ),
                width: MediaQuery.of(context).size.width,
                height: 20,
              ),
              Container(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 15
                    ),
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: <TextSpan>[
                          TextSpan(text: '${Translate.of(context).practice_area}: ', style: TextStyle(fontWeight: FontWeight.bold)),
                          TextSpan(text: elementList[0]['practice_area'], style: TextStyle(
                              color: Colors.black54
                          )),
                        ],
                      ),
                    )
                ),
                width: MediaQuery.of(context).size.width,
                height: 20,
              ),
              Container(
                margin: EdgeInsets.only(
                  top: 5,
                ),
                color: Colors.black12,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15
                  ),
                  child: Text(Translate.of(context).case_billing_information, style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                width: MediaQuery.of(context).size.width,
                height: 30,
              ),
              (elementList[0]['invoices'] != null ) ?
              (elementList[0]['invoices'].length > 0 ) ?
              Column(
                  children: <Widget>[
                    for(var item in elementList[0]['invoices'] )
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              (item['paid'] != '') ? CupertinoIcons.check_mark_circled : CupertinoIcons.clear_circled,
                              color: (item['paid'] == '') ? Colors.red : Colors.green,
                              size: 25.0,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Invoice # ${item['number']}', style: TextStyle(fontWeight: FontWeight.bold),),
                              Text((item['status'] != '') ? '${(item['status'] == 'overdue') ? 'Pending' : item['status']} - ${'\$' + item['total_amount'].substring(0, item['total_amount'].indexOf('.'))}' : '')
                            ],
                          ),
                          ( item['paid'] == '' ) ? Expanded(
                              child: Container(
                                alignment: Alignment.centerRight,
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        right: 15
                                    ),
                                    child: TextButton.icon(
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(Theme.Colors.loginGradientButton),
                                        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                                      ),
                                      label: Text(Translate.of(context).make_payment),
                                      icon: Icon(CupertinoIcons.money_dollar_circle),
                                      onPressed: () {
                                        _launchURL();
                                      },
                                    )
                                ),
                              )
                          ) : Container(),
                        ],
                      )
                  ]
              ) : Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(Translate.of(context).no_available_billings,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              ) : Container(),
        ])
    );
  }
}

_launchURL() async {
  const url = 'http://motion-law.mycase.com/paypage/guZfHDWgyxZT7izVjsnZsu4z';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
