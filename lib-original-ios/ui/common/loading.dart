import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class LoadingPage extends StatefulWidget {
  LoadingPage({Key? key}) : super(key: key);

  @override
  _LoadingPageState createState() => new _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Container(
        child:  new Container(
          child: new Center(
            child: new CupertinoActivityIndicator(),
          ),
        ),
      )
    );
  }
}
