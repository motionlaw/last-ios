import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_uploader/flutter_uploader.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../../style/theme.dart' as Theme;

Map data;
final documents = <Widget>[];
const String title = "FileUpload Sample app";
const String uploadURL = "https://us-central1-flutteruploader.cloudfunctions.net/upload";

class UploadItem {
  final String id;
  final String tag;
  final MediaType type;
  final int progress;
  final UploadTaskStatus status;

  UploadItem({
    this.id,
    this.tag,
    this.type,
    this.progress = 0,
    this.status = UploadTaskStatus.undefined,
  });

  UploadItem copyWith({UploadTaskStatus status, int progress}) => UploadItem(
      id: this.id,
      tag: this.tag,
      type: this.type,
      status: status ?? this.status,
      progress: progress ?? this.progress);

  bool isCompleted() =>
      this.status == UploadTaskStatus.canceled ||
          this.status == UploadTaskStatus.complete ||
          this.status == UploadTaskStatus.failed;
}

enum MediaType { Image, Video }

class CasesDetailed extends StatefulWidget {
  CasesDetailed({Key key}) : super(key: key);
  @override
  _CasesDetailedState createState() => new _CasesDetailedState();
}

class _CasesDetailedState extends State<CasesDetailed> {
  //final Cases cases;
  final _formKey = GlobalKey();
  FlutterUploader uploader = FlutterUploader();
  StreamSubscription _progressSubscription;
  StreamSubscription _resultSubscription;
  Map<String, UploadItem> _tasks = {};

  Future<http.Response> _asyncMethod() async {
    var box = await Hive.openBox('app_data');
    final _responseFuture = await http
        .get('https://qqv.oex.mybluehost.me/api/cases/files/D1675-21 Jacinto Santiago Anay', headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${box.get('token')}'
    });
    data = json.decode(_responseFuture.body);
    print(data['error']);
    if( data['error'] != true ){
      data = data['data'];
    } else {
      data = null;
    }
  }

  @override
  void initState() {
    _asyncMethod();
  }

  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Theme.Colors.loginGradientButton,
        child: Icon(
          CupertinoIcons.doc,
        ),
      ),
      body : CupertinoPageScaffold(
          navigationBar: CupertinoNavigationBar(
            middle: Text('Your Cases'),
          ),
          child: Scaffold(
              body: SafeArea(
                  child: ExpansionTile(
                    leading: Icon(CupertinoIcons.archivebox),
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
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold)),
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
                            Padding(
                              padding: EdgeInsets.all(0.0),
                              child: Container(
                                  width: MediaQuery.of(context).size.width * 0.70,
                                  child: new GestureDetector(
                                    onTap: () {
                                      showCupertinoDialog(
                                          context: context,
                                          builder: (context) => CupertinoAlertDialog(
                                            title: Text("CASE UPDATE",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w700)),
                                            content: Column(children: <Widget>[
                                              Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 10, 10, 20),
                                                child: Text(
                                                    'Please type the complete message of new update in this case.',
                                                    style: TextStyle(
                                                      fontSize: 12.0,
                                                    )),
                                              ),
                                              Builder(
                                                builder: (context) => Form(
                                                    key: _formKey,
                                                    child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .stretch,
                                                        children: [
                                                          CupertinoTextField(
                                                            keyboardType:
                                                            TextInputType
                                                                .multiline,
                                                            placeholder: "Message",
                                                            onChanged: (value) {
                                                              if (value.isEmpty) {
                                                                return 'Please enter a valid message';
                                                              }
                                                            },
                                                          ),
                                                        ])),
                                              )
                                            ]),
                                            actions: [
                                              CupertinoDialogAction(
                                                  child: Text('Close'),
                                                  onPressed: () =>
                                                      Navigator.pop(context)),
                                              CupertinoDialogAction(
                                                  child: Text('Save'),
                                                  onPressed: () =>
                                                      Navigator.pop(context)),
                                            ],
                                          ));
                                    },
                                    child: new Text("Add new update",
                                        style: TextStyle(
                                            fontSize: 12.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blue),
                                        textAlign: TextAlign.right),
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
                      ListTile(
                        visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                        dense: true,
                        title: Row(
                          children: <Widget>[
                            SizedBox(
                              width: 55,
                            ),
                            Text('DOCUMENTS',
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
                            children: [
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
                                      DataColumn(label: Text('Name')),
                                    ],
                                    rows: [
                                      for( var x in data['files'] )
                                      DataRow(cells: [
                                        DataCell(
                                          new InkWell(
                                              child: new Text(x['name']),
                                              onTap: () => launch(x['url'])
                                          ),
                                        ),
                                      ]),
                                    ],
                                  ),
                                ),
                              )
                            ]
                        )
                      )
                    ],
                  ))))
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
