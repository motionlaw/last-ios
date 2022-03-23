import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:motionlaw/generated/l10n.dart';
import '../../style/theme.dart' as Theme;
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import 'dart:convert';
import '../../utils/constants.dart' as constants;
import 'package:flutter/services.dart';


class SettingsPage extends StatefulWidget {
  SettingSubPage createState() => SettingSubPage();
}

Future<http.Response> _userMethod() async {
  var box = await Hive.openBox('app_data');
  final _responseFuture = await http
      .get(Uri.parse('${constants.API_BACK_URL}/api/user'), headers: <String, String>{
    'Accept': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${box.get('token')}'
  });
  return _responseFuture;
}

class SettingSubPage extends State<SettingsPage> {

  bool? showvalue = false;
  TextEditingController? _controller;
  TextEditingController? nameController;
  TextEditingController? last_nameController;
  TextEditingController? id_numberController;
  TextEditingController? phoneController;
  TextEditingController? emailController;
  TextEditingController? birthdayController;
  TextEditingController? pushController;

  @override
  void initState() {
    _userMethod().then((snapshot) {
      Map<String, dynamic> map = json.decode(snapshot.body);
      nameController = new TextEditingController(text: "${map['data']['name']}");
      last_nameController = new TextEditingController(text: "${map['data']['last_name']}");
      id_numberController = new TextEditingController(text: "${map['data']['id_number']}");
      phoneController = new TextEditingController(text: "${map['data']['phone_number']}");
      emailController = new TextEditingController(text: "${map['data']['email']}");
      birthdayController = new TextEditingController(text: "${map['data']['birthday']}");
      pushController = new TextEditingController(text: "${map['data']['push_auth']}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Text(Translate.of(context).settings, style: TextStyle(
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
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(Translate.of(context).label_profile_information,
                                    style: new TextStyle(fontSize: 18)))),
                        Divider(),
                        new ListTile(
                          leading: const Icon(Icons.person),
                          title: new TextField(
                            controller: nameController,
                            decoration: new InputDecoration(
                              hintText: Translate.of(context).input_first_name,
                            ),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.art_track_sharp),
                          title: new TextField(
                            controller: last_nameController,
                            decoration: new InputDecoration(
                              hintText: Translate.of(context).input_lastname,
                            ),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.phone),
                          title: new TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              hintText: Translate.of(context).input_phone_number,
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11),
                            ]
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.email_outlined),
                          title: new TextField(
                            controller: emailController,
                            decoration: new InputDecoration(
                              hintText: Translate.of(context).input_email,
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(Translate.of(context).label_notification_center,
                                    style: new TextStyle(fontSize: 18)))),
                        Divider(),
                        new ListTile(
                          leading: const Icon(Icons.mark_chat_unread_outlined),
                          title: Text(Translate.of(context).push_notification),
                          subtitle:
                              Text(Translate.of(context).advertise_push_notification),
                          trailing: Checkbox(
                            value: this.showvalue,
                            onChanged: (bool? value) {
                              setState(() {
                                this.showvalue = value;
                              });
                            },
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: 10.0, left: 8.0, right: 8.0),
                            width: double.infinity,
                            decoration: new BoxDecoration(
                              color: Theme.Colors.loginGradientButton,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: CupertinoButton(
                                child: Text(Translate.of(context).button_save,
                                    style: new TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                onPressed: () {
                                  print('Button pressed');
                                }))
                      ]))),
        ));
  }
}
