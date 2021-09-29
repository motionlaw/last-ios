import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../common/tawk/flutter_tawk.dart';
import '../../style/theme.dart' as Theme;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:hive/hive.dart';
import 'dart:async';


class ChatPage extends StatefulWidget {
  ChatPage({Key? key}) : super(key: key);
  @override
  _ChatPageState createState() => new _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
  with SingleTickerProviderStateMixin {
  WebViewController? _controller;

  String userName = '';
  String userEmail = '';
  String exitLabel = '';
  bool exitButton = true;

  Future getHive() async {
    var box = await Hive.openBox('app_data');
    var user = box.get('user_data');
    return user;
  }

  @override
  void initState() {
    super.initState();
    /*getHive().then((response) {
      this.setState((){
        userName = response['name'];
        userEmail = response['email'];
      },
      );
    });*/
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
          /*trailing: Visibility(
            child: new GestureDetector(
              onTap: () {
                _controller!.evaluateJavascript('Tawk_API.endChat();');
              },
              child: new Text("Close", style: TextStyle(color:Colors.white),),
            ),
            visible: true,
          ),*/
        ),
        child: Scaffold(
            backgroundColor: Theme.Colors.loginGradientButton,
            body: SafeArea(
              child: new WebView(
                initialUrl: 'https://tawk.to/chat/5ff64356c31c9117cb6c28b7/1ercve36t',
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController webViewController) async {
                  _controller = webViewController;
                },
              ),
            )
        )
    );
  }
}