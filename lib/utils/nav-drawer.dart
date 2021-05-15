import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class NavDrawer extends StatefulWidget {
  NavDrawer({Key? key}) : super(key: key);
  @override
  _NavDrawerState createState() => new _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  String? userName;
  _logout(context) async {
    Navigator.pushNamed(context, '/loading');
    var box = await Hive.openBox('app_data');
    await http.post(Uri.parse("https://qqv.oex.mybluehost.me/api/logout"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${box.get('token')}'
        });
    await box.delete('token');
    Timer(Duration(seconds: 2), () => {Navigator.pushNamed(context, '/login')});
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
    return Drawer(
      child: ListView(
        children: <Widget>[
          ListTile(
            title: Align(
              alignment: Alignment.center,
              child: SizedBox(
                  child: Image.asset('assets/img/Motionlaw-logogold.png',
                      height: 120)),
            ),
          ),
          Divider(),
          ListTile(
            leading: SizedBox(
                child: Image.asset('assets/img/avatar.png',
                    height: 60)),
            title: Text(userName??''),
            subtitle: Text('Manager')
          ),
          Divider(),
          ListTile(
            leading: Icon(CupertinoIcons.briefcase_fill),
            title: Text('Your Cases'),
            onTap: () => {Navigator.pushNamed(context, '/communication')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.chat_bubble_2),
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
            title: Text('Leave a review'),
            onTap: () => {Navigator.pushNamed(context, '/reviews')},
          ),
          ListTile(
            leading: Icon(CupertinoIcons.book),
            title: Text('Blog'),
            onTap: () => {Navigator.pushNamed(context, '/blog')},
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
