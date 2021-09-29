import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import '../../utils/functions.dart' as tool;
import '../../style/theme.dart' as Theme;

class ReferPage extends StatefulWidget {
  ReferPage({Key? key}) : super(key: key);
  @override
  _ReferPageState createState() => new _ReferPageState();
}

class _ReferPageState extends State<ReferPage>
  with SingleTickerProviderStateMixin {
  Map? data;
  String submit = 'SUBMIT';
  Color buttonColor = Theme.Colors.loginGradientButton;
  String? userName;
  TextEditingController phoneController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController _recipientController = new TextEditingController();

  Future submitForm(String name, String mail) async {
    if (tool.Functions.validateEmail(mail)) {
      var box = await Hive.openBox('app_data');
      var user = box.get('user_data');
      Map datos = {
        'name': name,
        'from':user['id'],
        'phone_or_email':mail
      };
      var body = json.encode(datos);
      http.Response response = await http.post(
          Uri.parse('https://qqv.oex.mybluehost.me/api/refers'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ${box.get('token')}'
          },
      body: body
      );
      data = json.decode(response.body);
      if( data!['code'] == 200 ){
        return showDialog<void>(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return CupertinoAlertDialog(
              title: Text('Refer message send success.'),
              content: Text('${userName} - Thank you for your referral to Motion Law.  We will reach out to them shortly!'),
              actions: <Widget>[
                CupertinoDialogAction(
                  child: Text('Close'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    _recipientController.clear();
                    emailController.clear();
                    this.setState(
                          () {
                        submit = 'SUBMIT';
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
  }

  Future<void> _handleClickMe(message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text('Required Fields!'),
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
  Future getHive() async {
    var box = await Hive.openBox('app_data');
    var user = box.get('user_data');
    return user;
  }

  @override
  void initState() {
    super.initState();
    getHive().then((response) {
      this.setState((){
        userName = response['name'];
        },
      );
    });
  }

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
            middle: Text('Refer a Friend or Relative', style: TextStyle(
              color: Colors.white,
            ),),
            backgroundColor: Theme.Colors.loginGradientButton,
            previousPageTitle: 'Back'
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
                                  'Type the full Name and Phone number / email address of the person you would like to introduce to Motion Law.')),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: _recipientController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Full Name of Friend or Relative',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(7.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                child: Text(
                                  "Provide at least one phone number or email address",
                                  style: new TextStyle(
                                      color: Colors.black45, fontSize: 14)
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: emailController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Email Address',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              controller: phoneController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '# Phone',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              //controller: _subjectController,
                              maxLines: 8,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText:
                                    "${userName} has introduced you to Motion Law.\nA Team member will be in touch with you soon - please reply to this email to book your initial free consultation right now or call (202) 918-1799",
                                border: OutlineInputBorder(),
                                //labelText: 'has introduced you to Motion Law... A Team member will be in touch with you soon - please reply to this email to book your initial free consultation right now or call (202) 918-1799',
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
                                  child: Text(submit,
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                  onPressed: (){
                                    if (_recipientController.text == "") {
                                      _handleClickMe(
                                          'Please provide either a phone number or an email address!');
                                      return;
                                    }
                                    if (emailController.text == "") {
                                      _handleClickMe(
                                          'Please provide either a phone number or an email address!');
                                      return;
                                    }
                                    this.setState(
                                          () {
                                        submit = 'LOADING...';
                                        buttonColor = Colors.black12;
                                      },
                                    );
                                    submitForm(_recipientController.text, emailController.text);
                                  }))
                        ]))))));
  }
}
