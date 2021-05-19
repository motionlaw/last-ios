import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../common/tawk/flutter_tawk.dart';
import '../../style/theme.dart' as Theme;
import 'package:hive/hive.dart';
import 'dart:async';


class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);
  @override
  _ChatPageState createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
  with SingleTickerProviderStateMixin {

  String userName = '';
  String userEmail = '';
  String exitLabel = '';

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
        userEmail = response['email'];
      },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Chat', style: TextStyle(
            color: Colors.white,
          ),),
          backgroundColor: Theme.Colors.loginGradientButton,
          previousPageTitle: 'Back',
        ),
        child: Scaffold(
            //backgroundColor: Colors.white,
            body: SafeArea(
              child: Tawk(
                directChatLink:
                    'https://tawk.to/chat/5ff64356c31c9117cb6c28b7/1ercve36t',
                visitor: TawkVisitor(
                  name: userName,
                  email: userEmail,
                  hash: 'as1d8asd'
                ),
                onLoad: () {
                  Timer(Duration(seconds: 5), () {
                    setState(() {
                      exitLabel = 'Close';
                    });
                  });
                },
                onLinkTap: (String url) {
                  print(url);
                },
                onChatEnd: (String url) {
                  print(url);
                },
                placeholder: Center(
                  child: Text('Loading...'),
                ),
              ),
            )));
  }
}