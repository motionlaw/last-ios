import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../style/theme.dart' as Theme;

class SettingsPage extends StatefulWidget {
  SettingSubPage createState() => SettingSubPage();
}

class SettingSubPage extends State<SettingsPage> {
  bool showvalue = false;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
            middle: Text('Settings', style: TextStyle(
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
                                child: Text('Profile Information',
                                    style: new TextStyle(fontSize: 18)))),
                        Divider(),
                        new ListTile(
                          leading: const Icon(Icons.person),
                          title: new TextField(
                            decoration: new InputDecoration(
                              hintText: "Name",
                            ),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.art_track_sharp),
                          title: new TextField(
                            decoration: new InputDecoration(
                              hintText: "Lastname",
                            ),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.account_box),
                          title: new TextField(
                            decoration: new InputDecoration(
                              hintText: "ID Number",
                            ),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.phone),
                          title: new TextField(
                            decoration: new InputDecoration(
                              hintText: "Phone Number",
                            ),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.email_outlined),
                          title: new TextField(
                            decoration: new InputDecoration(
                              hintText: "Email Address",
                            ),
                          ),
                        ),
                        new ListTile(
                          leading: const Icon(Icons.card_giftcard),
                          title: new TextField(
                            decoration: new InputDecoration(
                              hintText: "Birthday",
                            ),
                          ),
                        ),
                        Divider(),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text('Notification Center',
                                    style: new TextStyle(fontSize: 18)))),
                        Divider(),
                        new ListTile(
                          leading: const Icon(Icons.mark_chat_unread_outlined),
                          title: Text('Push Notification'),
                          subtitle:
                              Text('Enable Push notification on your mobile'),
                          trailing: Checkbox(
                            value: this.showvalue,
                            onChanged: (bool value) {
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
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            child: CupertinoButton(
                                child: Text('SAVE',
                                    style: new TextStyle(
                                        color: Colors.white, fontSize: 15)),
                                onPressed: () {
                                  print('Button pressed');
                                }))
                      ]))),
        ));
  }
}
