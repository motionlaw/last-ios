import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:url_launcher/url_launcher.dart';

class ReviewsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Reviews'),
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
                              child: Text(
                                  'Review Motion Law Inmigration in social networks, our firm work everyday for brings new and special content.')),
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SignInButton(
                                Buttons.Facebook,
                                text: "Comment on Facebook",
                                onPressed: () {
                                  _launchURL(
                                      'https://www.facebook.com/motionlawimmigration/');
                                },
                              )),
                          Padding(
                              padding: EdgeInsets.all(8.0),
                              child: SignInButton(
                                Buttons.Twitter,
                                text: "Comment on Twitter",
                                onPressed: () {
                                  _launchURL(
                                      'https://twitter.com/mlimmigration');
                                },
                              )),
                        ])))));
  }
}

_launchURL(urlDir) async {
  if (await canLaunch(urlDir)) {
    await launch(urlDir);
  } else {
    throw 'Could not launch $urlDir';
  }
}
