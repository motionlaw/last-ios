import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_tawk/flutter_tawk.dart';

class ChatPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Chat'),
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Tawk(
                directChatLink:
                    'https://tawk.to/chat/5ff64356c31c9117cb6c28b7/1ercve36t',
                visitor: TawkVisitor(
                  name: 'Ayoub AMINE',
                  email: 'ayoubamine2a@gmail.com',
                ),
                onLoad: () {
                  print('Hello Tawk!');
                },
                onLinkTap: (String url) {
                  print(url);
                },
                placeholder: Center(
                  child: Text('Loading...'),
                ),
              ),
            )));
  }
}
