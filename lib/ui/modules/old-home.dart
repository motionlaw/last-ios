import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/nav-drawer.dart';
import 'package:im_stepper/main.dart';
import 'package:im_stepper/stepper.dart';

Map data;

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => new _HomePageState();
}

_asyncMethod(context) async {
  /*var box = await Hive.openBox('app_data');
  print('Name: ${box.get('token')}');
  if( box.get('token') ){
    http.Response response = await http.post('http://qqv.oex.mybluehost.me/api/user',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ${box.get('token')}'
        }
    );
    data = json.decode(response.body);
    print(data);
  }*/
}

class _HomePageState extends State<HomePage> {
  int activeStep = 5; // Initial step set to 5.
  int upperBound = 0;
  @override
  void initState() {
    super.initState();
    _asyncMethod(context);
  }

  Widget build(BuildContext context) {
    return new Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Motion Law'),
      ),
      body: SafeArea(
          child: Column(children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 40.0, left:0.0, bottom: 40.0, right: 0.0),
              child: NumberStepper(
                numbers:[
                  1,
                  2,
                  3,
                  4,
                  5,
                  6,
                  7,
                  8,
                  9,
                  10,
                  11,
                  12
                ],
                activeStep: activeStep,

                upperBound: (bound) => upperBound = bound,
              ),
            ),
            header(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                    width: 150,
                    child: new CupertinoButton(
                      padding: EdgeInsets.all(10),
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        children: <Widget>[
                          Icon(CupertinoIcons.chat_bubble_2, size: 50.0),
                          Text("Contact us")
                        ],
                      ),
                      onPressed: () => {Navigator.pushNamed(context, '/chat')},
                    ))),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                    width: 150,
                    child: new CupertinoButton(
                      padding: EdgeInsets.all(10),
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        children: <Widget>[
                          Icon(CupertinoIcons.creditcard, size: 50.0),
                          Text("Pay Bill")
                        ],
                      ),
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/payment')},
                    ))),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                    width: 150,
                    child: new CupertinoButton(
                      padding: EdgeInsets.all(10),
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        children: <Widget>[
                          Icon(CupertinoIcons.t_bubble, size: 50.0),
                          Text("Leave a Review")
                        ],
                      ),
                      onPressed: () =>
                          {Navigator.pushNamed(context, '/reviews')},
                    ))),
            Padding(
                padding: EdgeInsets.all(20.0),
                child: Container(
                    width: 150,
                    child: new CupertinoButton(
                      padding: EdgeInsets.all(10),
                      color: Theme.of(context).primaryColor,
                      child: Column(
                        children: <Widget>[
                          Icon(CupertinoIcons.person_2_alt, size: 50.0),
                          Text("Refer a Friend")
                        ],
                      ),
                      onPressed: () => {Navigator.pushNamed(context, '/refer')},
                    ))),
          ],
        )
      ])),
    );
  }

  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 10.0,
              left: 40.0,
              bottom: 10.0,
              right: 20.0
            ),
            child: Text(
              headerText(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String headerText() {
    switch (activeStep) {
      case 1:
        return 'Assign Case';

      case 2:
        return 'Waiting for Introduction';

      case 3:
        return 'Collecting Evidence';

      case 4:
        return 'Preparing Packet';

      case 5:
        return 'Attorney Review';

      case 6:
        return 'Review and Signatures';

      case 7:
        return 'Filed';

      case 8:
        return 'Pending';

      case 9:
        return 'On Hold';

      case 10:
        return 'Pending Payment';

      case 11:
        return 'Upcoming Hearing';

      case 12:
        return 'Upcoming Trial';

      default:
        return 'Assign Case';
    }
  }
}
/*
Assign Case
Waiting for Introduction
Collecting Evidence
Preparing Packet
Attorney Review
Review and Signatures
Filed
Pending
On Hold
Pending Payment
Upcoming Hearing
Upcoming Trial
*/