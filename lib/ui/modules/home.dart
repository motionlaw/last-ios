import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/nav-drawer.dart';

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
        Image.asset(
          "assets/img/5fdb83a05febc.jpg",
          fit: BoxFit.fitWidth,
          //width: MediaQuery.of(context).size.width,
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
}
