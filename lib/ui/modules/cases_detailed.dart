import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:motionlaw/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../../style/theme.dart' as Theme;
import 'package:file_picker/file_picker.dart';
import '../../utils/constants.dart' as constants;
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
        .get(Uri.parse('${constants.API_BACK_URL}/api/cases/files/${arguments?['path']}'), headers: <String, String>{
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${box.get('token')}'
    });

    return _responseFuture;
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
  void dispose() {
    //selectedfile!.delete();
    arguments!.clear();
    arg!.clear();
    data.clear();
    dio.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text(Translate.of(context).you_cases, style: TextStyle(
            color: Colors.white,
          ),),
          backgroundColor: Theme.Colors.loginGradientButton,
          previousPageTitle: Translate.of(context).back,
        ),
        child: Scaffold(
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
                        child: expansionTile(arguments: arguments, formKey: _formKey, map: map, cont: context)
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
    @required this.cont
  }) : _formKey = formKey, super(key: key);

  final Map? arguments;
  final GlobalKey<State<StatefulWidget>>? _formKey;
  final Map? map;
  final cont;

  @override
  _expansionTileState createState() => _expansionTileState();
}

class _expansionTileState extends State<expansionTile> {
  Response? response;
  File? selectedfile;
  Dio dio = new Dio();

  void selectFile() async {
    if (mounted) {
      var box = await Hive.openBox('app_data');
      FilePickerResult result = (await FilePicker.platform.pickFiles(type: FileType.media))!;
      selectedfile = File(result.files.first.path!);

      Navigator.pushNamed(this.context, '/loading');

      FormData formdata = FormData.fromMap({
        "user_id": 2,
        "path": widget.arguments?['path'],
        "file": await MultipartFile.fromFile(
            selectedfile!.path,
            filename: basename(selectedfile!.path)
        ),
      });

      response = await dio.post('${constants.API_BACK_URL}/api/cases/files/upload',
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader:
            "Bearer ${box.get('token')}",
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
        data: formdata,
        onSendProgress: (int sent, int total) {

        },);
      if(response!.statusCode == 200){

        Navigator.pushNamed(this.context, '/casesDetailed',
            arguments: {
              'path': widget.arguments!['path'],
              'practice_area': widget.arguments!['practice_area'],
              'created_at': widget.arguments!['created_at'],
              'attorney': widget.arguments!['attorney'],
              'success': true
            });
        final snackBar = SnackBar(
          content: Text(Translate.of(this.context).file_upload),
          action: SnackBarAction(
            label: 'Got It!',
            onPressed: () {
              // Some code to undo the change.
            },
          ),
        );
        ScaffoldMessenger.of(this.context).showSnackBar(snackBar);
      } else {
        print("Error during connection to server.");
      }
    }
  }

  @override
  void dispose() {
    selectedfile!.delete();
    widget.arguments!.clear();
    data.clear();
    dio.close();
    super.dispose();
  }

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
                            TextSpan(text: widget.arguments!['path'], style: TextStyle(
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
                          TextSpan(text: dateFormat.format(DateTime.parse(widget.arguments!['created_at'])) + ' by ' + widget.arguments!['attorney'], style: TextStyle(
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
                          TextSpan(text: widget.arguments!['practice_area'], style: TextStyle(
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
                  top: 10,
                ),
                color: Colors.black12,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(
                      left: 15
                  ),
                  child: Text(Translate.of(context).calendar, style: TextStyle(
                      color: Colors.black54,
                      fontWeight: FontWeight.bold
                  ),),
                ),
                width: MediaQuery.of(context).size.width,
                height: 30,
              ),
              (widget.arguments?['calendar'] != null ) ?
              (widget.arguments?['calendar'].length > 0 ) ?
              Column(
                  children: <Widget>[
                    for(var item in widget.arguments?['calendar'] )
                      Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(15),
                              child: Icon(
                                CupertinoIcons.calendar,
                                color: Theme.Colors.loginGradientButton,
                                size: 25.0,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item['start'], style: TextStyle(fontWeight: FontWeight.bold),),
                                  Text(item['name'])
                                ],
                              )
                            ),
                          ]
                      )
              ]) : Container() : Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text('No events',
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
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
              (widget.arguments?['invoices'] != null ) ?
              (widget.arguments?['invoices'].length > 0 ) ?
              Column(
                  children: <Widget>[
                    for(var item in widget.arguments?['invoices'] )
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
                              Text((item['status'] != '') ? '${(item['status'] == 'overdue') ? 'Pending' : item['status']} - ${'\$' + item['total_amount']}' : '')
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
                                        //print(item);
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
                  child: Row(
                    children: [
                      Text(Translate.of(context).documents, style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold
                      ),),
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 15.0),
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
                              onTap: () {
                                //_CasesDetailedState().triggerSelectFile();
                                selectFile();
                              },
                              child: new Text(Translate.of(context).upload_document_button, style: TextStyle(
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                              ),)
                          ),
                        ),
                      )
                    ],
                  )
                ),
                width: MediaQuery.of(context).size.width,
                height: 30,
              ),
              ( widget.map?['data']['files'].length > 0 ) ?
              Column(
                  children: <Widget>[
                    for (int i = 0; i < widget.map?['data']['files'].length; i++)
                      Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(15),
                            child: Icon(
                              CupertinoIcons.doc_on_doc,
                              color: Theme.Colors.loginGradientButton,
                              size: 25.0,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () async {
                                  await launch(widget.map?['data']['files'][i]['url']);
                                },
                                child: new Text(widget.map?['data']['files'][i]['name'], style: TextStyle(fontWeight: FontWeight.bold),)
                              )
                              //Text('Individual Hearing')
                            ],
                          )
                        ],
                      )
                  ]
              ) : Row(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(15),
                    child: Text(Translate.of(context).folder_empty,
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 12.0,
                            fontWeight: FontWeight.bold)
                    ),
                  ),
                ],
              ),
            ]
        )
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