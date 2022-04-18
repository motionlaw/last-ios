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
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import '../../services/UpdateInformationDBService.dart';


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
  bool isEnabled = false;
  final nameController = new TextEditingController();
  final last_nameController = new TextEditingController();
  final id_numberController = new TextEditingController();
  final phoneController = new TextEditingController();
  final emailController = new TextEditingController();
  final pushController = new TextEditingController();
  PhoneNumber number = PhoneNumber(isoCode: 'US');

  Future updateFields() async {
    try {
      checkFields();
      if ( isEnabled == true ) {
        await UpdateInformationDBService.updateProfile(
            {
              'name': nameController.text,
              'last_name': last_nameController.text,
              'phone_number': phoneController.text,
              'email': emailController.text,
              'push_auth': (showvalue == true) ? 'yes' : 'no'
            }
        ).whenComplete(() =>
        {
          setState(() {
            isEnabled = false;
            _handleClickMe('Update Successful', 'Your settings have been updated!');
          })
        });
      }
    } catch (e) {
      print('error :: ${e}');
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
              child: Text(Translate.of(context).close),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void checkFields () {
    if ( nameController.text != "" && last_nameController.text != "" && phoneController.text != "" && emailController.text != "" ) {
      setState(() {
        isEnabled = true;
      });
    } else {
      setState(() {
        isEnabled = false;
      });
    }
  }

  @override
  void initState() {
    _userMethod().then((snapshot) {
      Map<String, dynamic> map = json.decode(snapshot.body);
      print('Soba :: ${map['data']['push_auth']}');
      nameController.text = map['data']['name'];
      last_nameController.text = map['data']['last_name'];
      id_numberController.text = map['data']['id_number'];
      phoneController.text = map['data']['phone_number'];
      emailController.text = map['data']['email'];
      showvalue = ( map['data']['push_auth'] == 'yes' ) ? true : false;
      setState(() {});
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
                            onChanged: (text) {
                              checkFields();
                            },
                            decoration: new InputDecoration(
                              hintText: Translate.of(context).input_first_name,
                            ),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.art_track_sharp),
                          title: new TextField(
                            controller: last_nameController,
                            onChanged: (text) {
                              checkFields();
                            },
                            decoration: new InputDecoration(
                              hintText: Translate.of(context).input_lastname,
                            ),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.phone),
                          /*title: new TextField(
                            controller: phoneController,
                            keyboardType: TextInputType.number,
                            decoration: new InputDecoration(
                              hintText: Translate.of(context).input_phone_number,
                            ),
                            inputFormatters: [
                              LengthLimitingTextInputFormatter(11),
                            ]
                          ),*/
                          title: InternationalPhoneNumberInput(
                            onInputChanged: (PhoneNumber number) {
                              checkFields();
                            },
                            initialValue: number,
                            selectorConfig: SelectorConfig(
                              selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
                              useEmoji: true,
                            ),
                            autoValidateMode: AutovalidateMode.disabled,
                            selectorTextStyle: TextStyle(color: Colors.black),
                            textFieldController: phoneController,
                            maxLength: 12,
                            keyboardType:
                            TextInputType.numberWithOptions(signed: true, decimal: true),
                            onSaved: (PhoneNumber number) {
                              print('On Saved: $number');
                            },
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.email_outlined),
                          title: new TextField(
                            controller: emailController,
                            onChanged: (text) {
                              checkFields();
                            },
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
                            activeColor: Theme.Colors.loginGradientButton,
                            value: this.showvalue,
                            onChanged: (bool? value) {
                              setState(() {
                                this.showvalue = value;
                              });
                              checkFields();
                            },
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(
                                top: 10.0, left: 8.0, right: 8.0),
                            width: double.infinity,
                            decoration: new BoxDecoration(
                              color: (isEnabled == false) ? Colors.black26 : Theme.Colors.loginGradientButton,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: CupertinoButton(
                                disabledColor: Colors.black26,
                                child: Text(Translate.of(context).button_save,
                                    style: new TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                onPressed: (isEnabled == false) ? null : updateFields,
                            ))
                      ]))),
        ));
  }
}
