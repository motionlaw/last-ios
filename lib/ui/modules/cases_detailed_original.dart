import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../../style/theme.dart' as Theme;
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:path/path.dart';

Map data = {};

class CasesDetailed extends StatefulWidget {
  CasesDetailed({Key key}) : super(key: key);
  @override
  _CasesDetailedState createState() => new _CasesDetailedState();
}

class _CasesDetailedState extends State<CasesDetailed> {
  final _formKey = GlobalKey();
  Map arguments;
  File selectedfile;
  Response response;
  String progress;
  String var_path = '';
  String practice_area = '';
  String created_at = '';
  String attorney = '';
  Dio dio = new Dio();

  Future<http.Response> _asyncMethod(context) async {
    arguments = await ModalRoute.of(context).settings.arguments as Map;
    var box = await Hive.openBox('app_data');
    if( arguments['path'] != null ) {
      final _responseFuture = await http
          .get('https://qqv.oex.mybluehost.me/api/cases/files/${arguments['path']}', headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${box.get('token')}'
      });

      try {
        data = json.decode(_responseFuture.body);
        if( data['error'] != true ){
          setState(() {
            data = data['data'];
            var_path = arguments['path'];
            practice_area = arguments['practice_area'];
            created_at = arguments['created_at'];
            attorney = arguments['attorney'];
          });

        } else {
          setState(() {
            data = {};
          });
        }
      } on FormatException catch (e) {
        setState(() {
          data = {};
        });
      }
    }
  }

  void selectFile(context) async {
    var box = await Hive.openBox('app_data');
    FilePickerResult result = await FilePicker.platform.pickFiles(type: FileType.any);
    selectedfile = File(result.files.first.path);

    Navigator.pushNamed(context, '/loading');

    FormData formdata = FormData.fromMap({
      "user_id": 2,
      "path": arguments['path'],
      "file": await MultipartFile.fromFile(
          selectedfile.path,
          filename: basename(selectedfile.path)
      ),
    });

    dio.options.headers["Authorization"] = "Bearer ${box.get('token')}";

    response = await dio.post('https://qqv.oex.mybluehost.me/api/cases/files/upload',
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent/total*100).toStringAsFixed(2);
        setState(() {
          progress = "$sent" + " Bytes of " "$total Bytes - " +  percentage + " % uploaded";
          print(progress);
          //update the progress
        });
      },);
    if(response.statusCode == 200){
      //print(response.toString());
      Navigator.pushNamed(context, '/casesDetailed');
    }else{
      print("Error during connection to server.");
    }
  }

  @override
  void initState() {
    //_asyncMethod();
  }

  Widget build(BuildContext context) {
    _asyncMethod(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          selectFile(context);
        },
        backgroundColor: Theme.Colors.loginGradientButton,
        child: Icon(
          CupertinoIcons.doc,
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
                  child: ExpansionTile(
                    initiallyExpanded: true,
                    leading: Icon(CupertinoIcons.archivebox),
                    title: Text(
                      var_path,
                      style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      practice_area,
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
                              child: Text('${created_at} by ${attorney}',
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
                                width: 30,
                              ),
                              Padding(
                                padding: EdgeInsets.all(0.0),
                                child: Container(
                                  alignment: Alignment.centerLeft,
                                  width: MediaQuery.of(context).size.width * 0.80,
                                  child: DataTable(
                                    columns: [
                                      DataColumn(label: Text('Name')),
                                      DataColumn(label: Text('Action'))
                                    ],
                                    rows: List<DataRow>.generate(
                                      2,
                                          (index) => DataRow(
                                        cells: [
                                          DataCell(
                                              Text(data['files'][index]['name'])
                                          ),
                                          DataCell(
                                              Text('Row $index')
                                          )
                                        ],
                                      ),
                                    ),
                                    /*rows:
                                      [
                                        if ( data['files'] != null)
                                        for( var x in data['files'] )
                                        DataRow(cells: [
                                          DataCell(
                                            Container(
                                                width: 185,
                                                child: new Text(x['name'])
                                          )),
                                          DataCell(
                                              new GestureDetector(
                                                  onTap: (){
                                                    launch(x['url']);
                                                  },
                                                  child: Container(
                                                      width: 60,
                                                      height:40,
                                                      child: Icon(CupertinoIcons.down_arrow,
                                                          color: Colors.blue)
                                                  ))
                                          )
                                        ])

                                      else
                                        DataRow(cells: [
                                          DataCell(
                                            Text('The folder of this case is empty.')
                                          )
                                        ]),
                                      ]*/
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
