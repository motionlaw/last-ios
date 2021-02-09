import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ReviewsPage extends StatefulWidget {
  ReviewsPage({Key key}) : super(key: key);


  @override
  _ReviewsPageState createState() => new _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage>
  with SingleTickerProviderStateMixin {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Reviews'),
        ),
        child: Scaffold(
            body: SafeArea(
              child: Stack(
                  children: <Widget>[
                    WebView(
                      initialUrl: 'https://www.grade.us/motionlaw',
                      onPageFinished: (finish) {
                        setState(() {
                          isLoading = false;
                        });
                      },
                    ),
                    isLoading ? Center( child: Text('Loading...'))
                        : Stack(),
                  ])
            )));
  }
}
