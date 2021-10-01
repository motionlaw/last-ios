import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../utils/functions.dart' as tool;
import '../../style/theme.dart' as Theme;
import '../../utils/constants.dart' as constants;

class ConsultationPage extends StatefulWidget {
  ConsultationPage({Key? key}) : super(key: key);
  @override
  _ReferPageState createState() => new _ReferPageState();
}

class _ReferPageState extends State<ConsultationPage>
    with SingleTickerProviderStateMixin {
  Map? data;
  String submit = 'SUBMIT';
  Color buttonColor = Theme.Colors.loginGradientButton;

  Future submitForm(String option) async {
    var box = await Hive.openBox('app_data');
    Map datos = {
      'consultation': option,
    };
    var body = json.encode(datos);
    http.Response response = await http.post(
        Uri.parse('${constants.API_BACK_URL}/api/consultation'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${box.get('token')}'
        },
        body: body
    );
    data = json.decode(response.body);
    print('Esta es la respuesta ${data}');
    if(data!['error'] == false){
      _handleClickMe('Thank you.', data!['response']);
    } else {
      _handleClickMe('Please Contact Support', 'Code 01023');
    }
  }

  Future<void> _handleClickMe(title, message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Close'),
              onPressed: () {
                Navigator.pushNamed(context, '/home');
              },
            ),
          ],
        );
      },
    );
  }

  Future getHive() async {
    var box = await Hive.openBox('app_data');
    var user = box.get('user_data');
    return user;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body : CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
                middle: Text('Thank you for registering', style: TextStyle(
                  color: Colors.white,
                ),),
                backgroundColor: Theme.Colors.loginGradientButton,
                automaticallyImplyLeading: false,
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
                                      'Thank you for registering. You do not have an active case with Motion Law yet! Schedule a FREE consultation with Motion Law today, select from the below: ')),
                              SizedBox(height: 15),
                              FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                color: buttonColor,
                                onPressed: () {
                                  submitForm('yes');
                                },
                                child:
                                Text(
                                  'Schedule a FREE Consultation',
                                  style: TextStyle(color: Colors.white,),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                'We will call you back',
                              ),
                              SizedBox(height: 25),
                              FlatButton(
                                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                                color: buttonColor,
                                onPressed: () {
                                  submitForm('no');
                                },
                                child:
                                Text(
                                  'Not now, Thank you',
                                  style: TextStyle(color: Colors.white,),
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                  'Just let me see the App features',
                              )
                            ]))))));
  }
}
