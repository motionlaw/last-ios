import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

_logout(context) async {
  Navigator.pushNamed(context, '/loading');
  var box = await Hive.openBox('app_data');
  await http.post("https://qqv.oex.mybluehost.me/api/logout",
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${box.get('token')}'
      });
  await box.delete('token');
  Timer(Duration(seconds: 2), () => {Navigator.pushNamed(context, '/login')});
}

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Align(
              alignment: Alignment.centerLeft,
              child: SizedBox(
                  child: Image.asset('assets/img/Motionlaw-logogold.png',
                      height: 110)),
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(CupertinoIcons.chat_bubble_2),
            title: Text('Communication'),
            onTap: () => {Navigator.pushNamed(context, '/communication')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.at),
            title: Text('Chat'),
            onTap: () => {Navigator.pushNamed(context, '/chat')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.creditcard_fill),
            title: Text('Make a Payment'),
            onTap: () => {Navigator.pushNamed(context, '/payment')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.mail_solid),
            title: Text('Contact Us'),
            onTap: () => {Navigator.pushNamed(context, '/support')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.person_2_alt),
            title: Text('Refer a Friend'),
            onTap: () => {Navigator.pushNamed(context, '/refer')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.device_phone_portrait),
            title: Text('Reviews'),
            onTap: () => {Navigator.pushNamed(context, '/reviews')},
          ),
          Divider(),
          ListTile(
            leading: Icon(CupertinoIcons.gear_solid),
            title: Text('Settings'),
            onTap: () => {Navigator.pushNamed(context, '/settings')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.delete_left),
            title: Text('Logout'),
            onTap: () => {_logout(context)},
          ),
        ],
      ),
    );
  }
}
