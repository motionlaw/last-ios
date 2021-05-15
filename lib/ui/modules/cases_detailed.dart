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
bool fbVisible = false;
var allFiles = false;

class CasesDetailed extends StatefulWidget {
  CasesDetailed({Key? key}) : super(key: key);
  @override
  _CasesDetailedState createState() => new _CasesDetailedState();
}

class _CasesDetailedState extends State<CasesDetailed> {
  final _formKey = GlobalKey();
  Map? arg;
  Map? arguments;
  File? selectedfile;
  Response? response;
  String? progress;
  String var_path = '';
  String practice_area = '';
  String created_at = '';
  String attorney = '';
  Dio dio = new Dio();

  Future<http.Response> _asyncMethod(context) async {
    arguments = await ModalRoute.of(context)?.settings.arguments as Map;
    var box = await Hive.openBox('app_data');
    final _responseFuture = await http
        .get(Uri.parse('https://qqv.oex.mybluehost.me/api/cases/files/${arguments?['path']}'), headers: <String, String>{
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${box.get('token')}'
    });

    return _responseFuture;
  }

  void selectFile(context) async {
    var box = await Hive.openBox('app_data');
    FilePickerResult result = (await FilePicker.platform.pickFiles(type: FileType.media))!;
    selectedfile = File(result.files.first.path!);

    Navigator.pushNamed(context, '/loading');

    FormData formdata = FormData.fromMap({
      "user_id": 2,
      "path": arguments?['path'],
      "file": await MultipartFile.fromFile(
          selectedfile!.path,
          filename: basename(selectedfile!.path)
      ),
    });

    dio.options.headers["Authorization"] = "Bearer ${box.get('token')}";

    response = await dio.post('https://qqv.oex.mybluehost.me/api/cases/files/upload',
      data: formdata,
      onSendProgress: (int sent, int total) {
        String percentage = (sent/total*100).toStringAsFixed(2);
        setState(() {
          progress = "$sent" + " Bytes of " "$total Bytes - " +  percentage + " % uploaded";
        });
      },);
    if(response!.statusCode == 200){
      //print(response.toString());
      Navigator.pushNamed(context, '/casesDetailed',
          arguments: {
            'path': var_path,
            'practice_area': practice_area,
            'created_at': created_at,
            'attorney': attorney,
            'success': true
          });
      final snackBar = SnackBar(
        content: Text('File Uploaded succesfully!'),
        action: SnackBarAction(
          label: 'Got It!',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      print("Error during connection to server.");
    }
  }

  void stateParams(context) async {
    arguments = await ModalRoute.of(context)?.settings.arguments as Map;
    setState(() {
      var_path = arguments?['path'];
      practice_area = arguments?['practice_area'];
      created_at = arguments?['created_at'];
      attorney = arguments?['attorney'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Your Cases', style: TextStyle(
          color: Colors.white,
        ),),
        backgroundColor: Theme.Colors.loginGradientButton,
        previousPageTitle: 'Back',
      ),
      child: Scaffold(
          floatingActionButton: Visibility(
            visible: true,
            child: FloatingActionButton.extended(
              onPressed: () {
                selectFile(context);
              },
              backgroundColor: Theme.Colors.loginGradientButton,
              label: Row(
                children: <Widget>[Text("Upload Document  "), Icon(CupertinoIcons.cloud_upload)],
              ),
              icon: Container(),
            )
          ),
          body: FutureBuilder(
            future: _asyncMethod(context),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if ( snapshot.connectionState == ConnectionState.waiting ) {
                return Align(
                    alignment: Alignment.bottomLeft,
                    child: new Container(
                      height: MediaQuery.of(context).size.height,
                      child: new Center(
                        child: new CupertinoActivityIndicator(),
                      ),
                  ));
              } else if ( snapshot.hasError ) {
                Map<String, dynamic> map = {};
                return SingleChildScrollView(
                  child: expansionTile(arguments: arguments, formKey: _formKey, map: map)
                );
              } else {
                Map<String, dynamic> map = json.decode(snapshot.data.body);
                return SingleChildScrollView(
                  child: expansionTile(arguments: arguments, formKey: _formKey, map: map)
                );
              }
            })
          )
      );
  }
}

class expansionTile extends StatefulWidget {
  const expansionTile({
    Key? key,
    @required this.arguments,
    @required GlobalKey<State<StatefulWidget>>? formKey,
    @required this.map,
  }) : _formKey = formKey, super(key: key);

  final Map? arguments;
  final GlobalKey<State<StatefulWidget>>? _formKey;
  final Map<String, dynamic>? map;

  @override
  _expansionTileState createState() => _expansionTileState();
}

class _expansionTileState extends State<expansionTile> {
  @override
  void initState() {
    if ( widget.map!.length > 0 ) {
      setState(() {
        allFiles = true;
      });
    }
    setState(() {
      fbVisible = true;
    });
  }

  Widget build(BuildContext context) {
    return ExpansionTile(
        initiallyExpanded: true,
        trailing: SizedBox.shrink(),
        leading: Icon(CupertinoIcons.archivebox_fill),
        title: Text(
          widget.arguments!['path'],
          style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.arguments!['practice_area'],
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
                  child: Text('${widget.arguments!['created_at']} by ${widget.arguments!['attorney']}',
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
                                        key: widget._formKey,
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
                                                  /*if (value.isEmpty) {
                                                    return 'Please enter a valid message';
                                                  }*/
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
                Text('CALENDAR',
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
                  width: 30,
                ),
                Padding(
                  padding: EdgeInsets.all(0.0),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    width: MediaQuery.of(context).size.width * 0.80,
                    child: DataTable(
                      columnSpacing: 30,
                      columns: [
                        DataColumn(label: Text('Date')),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                                  'Time',
                                  textAlign: TextAlign.center,
                                )
                            )
                        ),
                        DataColumn(
                            label: Expanded(
                                child: Text(
                                  'Title',
                                  textAlign: TextAlign.center,
                                ))
                        )
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Container(
                              width: 45, //SET width
                              child: Text('June 6'))),
                          DataCell(Container(
                              width: 75, //SET width
                              child: Text('7AM - 8AM'))),
                          DataCell(Container(
                              width: 150, //SET width
                              child: Text('Individual Hearing')))
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
                            rows: [
                              if ( widget.map!.length > 1 )
                                  for (int i = 0; i < 2; i++)
                                      DataRow(cells: [
                                        DataCell(
                                            Container(
                                                width: 185,
                                                child: new Text(widget.map!['data']['files'][i]['name'])
                                            )),
                                        DataCell(
                                            new GestureDetector(
                                                onTap: (){
                                                  launch(widget.map!['data']['files'][i]['url']);
                                                },
                                                child: Container(
                                                    width: 60,
                                                    height: 40,
                                                    child: Icon(CupertinoIcons.cloud_download_fill,
                                                        color: Colors.blue)
                                                ))
                                        )
                                      ])

                              else
                                DataRow(cells: [
                                  DataCell(
                                      Text('The folder of this case is empty.')
                                  ),
                                  DataCell(SizedBox(width: 0.0, height: 0.0))
                                ]),
                            ]
                        ),
                      ),
                    )
                  ]
              )
          ),
          ListTile(
            visualDensity: VisualDensity(horizontal: 0, vertical: -4),
            dense: true,
            title: Row(
              children: <Widget>[
                SizedBox(
                  width: 55,
                ),
                Visibility(
                  visible: allFiles,
                  child: Text('Please login to your MyCase portal to view all of your \ndocuments.',
                    style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12.0
                    )),
                ),
              ],
            ),
          ),
        ]
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
