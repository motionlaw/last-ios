import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:motionlaw/generated/l10n.dart';
import '../../style/theme.dart' as Theme;
import '../../utils/constants.dart' as constants;

List<dynamic>? staff;

Future<String> _asyncMethod() async {
  var box = await Hive.openBox('app_data');
  final _responseFuture = await http
      .get(Uri.parse('${constants.API_BACK_URL}/api/staff'), headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${box.get('token')}'
  });
  if ( _responseFuture.statusCode == 200 ) {
    //staff = json.decode(_responseFuture.body);
    return _responseFuture.body;
  } else {
    throw Exception('Failed to load post');
  }
}

class SupportPage extends StatefulWidget {
  SupportPage({Key? key}) : super(key: key);
  @override
  _SupportPageState createState() => new _SupportPageState();
}

class _SupportPageState extends State<SupportPage>
  with SingleTickerProviderStateMixin {
  Map? data;
  int _selectedIndex = 0;
  Color buttonColor = Theme.Colors.loginGradientButton;
  String submit = 'SUBMIT';
  TextEditingController _staffController = new TextEditingController();
  TextEditingController _subjectController = new TextEditingController();
  TextEditingController _messageController = new TextEditingController();

  Future<void> _handleClickMe(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(Translate.of(context).required_fields),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future submitForm(String staff, String subject, String message) async {
    var box = await Hive.openBox('app_data');
    var user = box.get('user_data');
    Map datos = {
      'message': subject + ' : ' + message,
      'staff': staff,
      'from': user['id'],
      'device': 'mobile'
    };
    var body = json.encode(datos);
    http.Response response = await http.post(
        Uri.parse('${constants.API_BACK_URL}/api/support'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${box.get('token')}'
        },
        body: body
    );
    data = json.decode(response.body);
    if( data?['code'] == 200 ){
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return CupertinoAlertDialog(
            title: Text(Translate.of(context).sent_succesfully_title),
            content: Text(Translate.of(context).sent_succesfully),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _subjectController.clear();
                  _messageController.clear();
                  this.setState(
                        () {
                      submit = Translate.of(context).button_submit;
                      buttonColor = Theme.Colors.loginGradientButton;
                    },
                  );
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _asyncMethod().then((snapshot){
      setState(() {
        staff = json.decode(snapshot);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Text(Translate.of(context).contact_us, style: TextStyle(
              color: Colors.white,
            ),),
            backgroundColor: Theme.Colors.loginGradientButton,
            previousPageTitle: Translate.of(context).back
        ),
        child: Scaffold(
          body: SafeArea(
              child: Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                                Translate.of(context).contact_us_header)),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            onTap: () {
                              showModalBottomSheet(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 250.0,
                                      child: CupertinoPicker(
                                          itemExtent: 32.0,
                                          onSelectedItemChanged: (int index) {
                                            setState(() {
                                              _staffController.text = staff![index]['name'];
                                            });
                                          },
                                        children: List.generate(staff!.length, (index){
                                          return Text(staff![index]['name'].toString());
                                        }),
                                      ),
                                    );
                                  });
                            },
                            controller: _staffController,
                              showCursor: false,
                              readOnly: true,
                              decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: Translate.of(context).input_staff_member
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _subjectController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: Translate.of(context).input_subject,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: TextField(
                            controller: _messageController,
                            //textAlignVertical: TextAlignVertical.top,
                            expands: false,
                            maxLines: 8,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: Translate.of(context).input_message,
                            ),
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: 10.0, left: 8.0, right: 8.0),
                            width: double.infinity,
                            decoration: new BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: CupertinoButton(
                                child: Text(Translate.of(context).button_submit,
                                    style: new TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                onPressed: () {
                                  if (_staffController.text == "") {
                                    _handleClickMe(
                                        Translate.of(context).validation_submit);
                                    return;
                                  }
                                  if (_subjectController.text == "") {
                                    _handleClickMe(
                                        Translate.of(context).validation_submit);
                                    return;
                                  }
                                  if (_messageController.text == "") {
                                    _handleClickMe(
                                        Translate.of(context).validation_submit);
                                    return;
                                  }
                                  this.setState(
                                        () {
                                      submit = Translate.of(context).loading;
                                      buttonColor = Colors.black12;
                                    },
                                  );
                                  submitForm(_staffController.text, _subjectController.text, _messageController.text);
                                }))
                      ])
                  )),
        ));
  }
}
