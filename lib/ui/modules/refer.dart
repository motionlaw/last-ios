import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ReferPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Refer a Friend'),
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
                                  'Type the phone number or email address of friend you want to introduce to Motion Law.')),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              //controller: _recipientController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Full Name Refered',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              //controller: _recipientController,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: '# Phone / Email Address',
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(8.0),
                            child: TextField(
                              //controller: _subjectController,
                              maxLines: 8,
                              readOnly: true,
                              decoration: InputDecoration(
                                hintText:
                                    "Diego has introduced you to Motion Law.\nA Team member will be in touch with you soon - please reply to this email to book your initial free consultation right now or call (202) 918-1799",
                                border: OutlineInputBorder(),
                                //labelText: 'has introduced you to Motion Law... A Team member will be in touch with you soon - please reply to this email to book your initial free consultation right now or call (202) 918-1799',
                              ),
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
                                  child: Text('SUBMIT',
                                      style: new TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                  onPressed: () {
                                    print('Button pressed');
                                  }))
                        ])))));
  }
}
