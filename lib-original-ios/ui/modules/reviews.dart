import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../style/theme.dart' as Theme;

class ReviewsPage extends StatefulWidget {
  ReviewsPage({Key? key}) : super(key: key);


  @override
  _ReviewsPageState createState() => new _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage>
  with SingleTickerProviderStateMixin {
  bool isLoading = true;

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
            middle: Text('Reviews', style: TextStyle(
              color: Colors.white,
            ),),
            backgroundColor: Theme.Colors.loginGradientButton,
            previousPageTitle: 'Back'
        ),
        child: Scaffold(
            body: SafeArea(
              child: Stack(
                  children: <Widget>[
                    WebView(
                      initialUrl: 'https://www.grade.us/motionlaw',
                      javascriptMode: JavascriptMode.unrestricted,
                      onPageFinished: (finish) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                    isLoading ? Center( child: Text('Loading...'))
                        : Stack(),
                  ])
            ))));
  }
}
