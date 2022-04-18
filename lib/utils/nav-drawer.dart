import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:motionlaw/generated/l10n.dart';
import '../../utils/constants.dart' as constants;

class NavDrawer extends StatefulWidget {
  NavDrawer({Key? key}) : super(key: key);
  @override
  _NavDrawerState createState() => new _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String? userName;
  bool _hasCases = false;
  _logout(context) async {
    Navigator.pushNamed(context, '/loading');
    var box = await Hive.openBox('app_data');
    await http.post(Uri.parse("https://motionlaw.us/api/logout"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${box.get('token')}'
        });
    await box.delete('token');
    Timer(Duration(seconds: 2), () => {Navigator.pushNamed(context, '/login')});
  }

  Future<http.Response> _menu() async {
    var _responseFuture;
    try {
      var box = await Hive.openBox('app_data');
      _responseFuture = await http
          .get(Uri.parse('${constants.API_BACK_URL}/api/menu'), headers: <String, String>{
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${box.get('token')}'
      });
      final body = json.decode(_responseFuture.body);
      if ( body['response'] == true ) {
        setState(() {
          _hasCases = true;
        });
      }
    } catch (e) {
      print('Error - home.dart (_casesMethod) : ${e.toString()}');
    }
    return _responseFuture;
  }

  Future getHive() async {
    var box = await Hive.openBox('app_data');
    var user = box.get('user_data');
    return user;
  }

  @override
  void initState() {
    super.initState();
    _menu();
    getHive().then((response) {
      this.setState((){
        userName = response['name'] + ' ' + response['last_name'];
      },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Align(
              heightFactor: 0.7,
              alignment: Alignment.centerLeft,
              child: SizedBox(
                  child: Image.asset('assets/img/Motionlaw-logogold.png',
                      height: 100)),
            ),
          ),
          Divider(),
          ListTile(
              leading: SizedBox(
                  child: Image.asset('assets/img/avatar.png',
                      height: 40)),
              title: Text(userName??'', style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold
              ))
          ),
          Divider(),
          ListTile(
            leading: Icon(CupertinoIcons.briefcase_fill),
            title: Text(Translate.of(context).you_cases),
            onTap: () => {Navigator.pushNamed(context, '/communication')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.chat_bubble_2),
            title: Text(Translate.of(context).chat),
            onTap: () => {Navigator.pushNamed(context, '/chat')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.creditcard_fill),
            title: Text(Translate.of(context).make_payment),
            onTap: () => {Navigator.pushNamed(context, '/payment')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.mail_solid),
            title: Text(Translate.of(context).contact_us),
            onTap: () => {Navigator.pushNamed(context, '/support')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.person_2_alt),
            title: Text(Translate.of(context).refer_friend),
            onTap: () => {Navigator.pushNamed(context, '/refer')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.device_phone_portrait),
            title: Text(Translate.of(context).leave_review),
            onTap: () => {Navigator.pushNamed(context, '/reviews')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.book),
            title: Text(Translate.of(context).blog),
            onTap: () => {Navigator.pushNamed(context, '/blog')},
          ),
          Divider(),
          ListTile(
            leading: Icon(CupertinoIcons.gear_solid),
            title: Text(Translate.of(context).settings),
            onTap: () => {Navigator.pushNamed(context, '/settings')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.delete_left),
            title: Text(Translate.of(context).logout),
            onTap: () => {_logout(context)},
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.15,
            alignment: FractionalOffset.bottomCenter,
            child: Text('V1.1.17', style: TextStyle(
                fontSize: 12.0,
                fontWeight: FontWeight.bold
            ),),
          )
        ],
      ),
    );
  }
}
