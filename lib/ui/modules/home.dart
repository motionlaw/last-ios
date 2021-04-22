import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/nav-drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => new _HomePageState();
}

Future<http.Response> _asyncMethod() async {
  var box = await Hive.openBox('app_data');
  final _responseFuture = await http
      .get('https://qqv.oex.mybluehost.me/blog-list', headers: <String, String>{
    'Content-Type': 'application/json; charset=UTF-8',
    'Authorization': 'Bearer ${box.get('token')}'
  });
  return _responseFuture;
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Motion Law'),
        ),
        body: Example8());
  }
}

class Example8 extends StatelessWidget {
  const Example8({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: NewWidget()
    ));
  }
}

class NewWidget extends StatefulWidget {
  @override
  _NewWidgetState createState() => _NewWidgetState();
}

class _NewWidgetState extends State<NewWidget> {
  String url = '';
  String title = 'Loading...';
  String content = 'Loading...';

  @override
  void initState() {
    _asyncMethod().then((snapshot) {
      Map<String, dynamic> map = json.decode(snapshot.body);
      print('Resultado :: ${map['data']['post_date']}');
      setState(() {
        url = map['data']['post_thumbnail'];
        title = map['data']['post_title'];
        content = map['data']['post_name'];
      });
    });
  }

  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
        padding: const EdgeInsets.only(
          left: 0,
          top: 0,
          right: 0,
          bottom: 0,
        ),
        child: Image.asset(
          "assets/img/DC-Immigration-Law-Firm.png",
        ),
      ),
      Container(
        constraints: const BoxConstraints(maxHeight: 150),
        color: Colors.white,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.end,
              isFirst: true,
              afterLineStyle: const LineStyle(
                color: Colors.green,
                thickness: 7,
              ),
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 60,
                padding: const EdgeInsets.all(8),
                indicator: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                      child:
                          Icon(CupertinoIcons.check_mark, color: Colors.white, size: 20)),
                ),
              ),
              startChild: const _Child(
                text: "Assign Case",
              ),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.end,
              beforeLineStyle: const LineStyle(
                color: Colors.green,
                thickness: 7,
              ),
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 60,
                padding: const EdgeInsets.symmetric(vertical: 8),
                drawGap: true,
                indicator: Container(
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                      child:
                          Icon(CupertinoIcons.check_mark, color: Colors.white, size: 20)),
                ),
              ),
              startChild: const _Child(
                text: 'Waiting for\nIntroduction',
              ),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.end,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 60,
                padding: const EdgeInsets.all(8),
                indicator: Container(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '3',
                      style: TextStyle(
                        color: Color(0XFF141035),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              startChild: const _Child(
                text: 'Collecting\nEvidence',
              ),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.end,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 60,
                padding: const EdgeInsets.all(8),
                indicator: Container(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '4',
                      style: TextStyle(
                        color: Color(0XFF141035),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              startChild: const _Child(
                text: 'Preparing\nPacket',
              ),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.end,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 60,
                padding: const EdgeInsets.all(8),
                indicator: Container(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '5',
                      style: TextStyle(
                        color: Color(0XFF141035),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              startChild: const _Child(
                text: 'Attorney\nReview',
              ),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.end,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 60,
                padding: const EdgeInsets.all(8),
                indicator: Container(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '6',
                      style: TextStyle(
                        color: Color(0XFF141035),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              startChild: const _Child(
                text: 'Review and\nSignatures',
              ),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.end,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 60,
                padding: const EdgeInsets.all(8),
                indicator: Container(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '7',
                      style: TextStyle(
                        color: Color(0XFF141035),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              startChild: const _Child(
                text: 'Filed',
              ),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.end,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 60,
                padding: const EdgeInsets.all(8),
                indicator: Container(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '8',
                      style: TextStyle(
                        color: Color(0XFF141035),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              startChild: const _Child(
                text: 'Pending',
              ),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.end,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 60,
                padding: const EdgeInsets.all(8),
                indicator: Container(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '9',
                      style: TextStyle(
                        color: Color(0XFF141035),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              startChild: const _Child(
                text: 'On Hold',
              ),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.end,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 60,
                padding: const EdgeInsets.all(8),
                indicator: Container(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '10',
                      style: TextStyle(
                        color: Color(0XFF141035),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              startChild: const _Child(
                text: 'Pending\nPayment',
              ),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.end,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 60,
                padding: const EdgeInsets.all(8),
                indicator: Container(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '11',
                      style: TextStyle(
                        color: Color(0XFF141035),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              startChild: const _Child(
                text: 'Upcoming\nHearing',
              ),
            ),
            TimelineTile(
              axis: TimelineAxis.horizontal,
              alignment: TimelineAlign.end,
              isLast: true,
              indicatorStyle: IndicatorStyle(
                width: 40,
                height: 60,
                padding: const EdgeInsets.all(8),
                indicator: Container(
                  decoration: const BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        color: Colors.grey,
                      ),
                    ),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text(
                      '12',
                      style: TextStyle(
                        color: Color(0XFF141035),
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
              startChild: const _Child(
                text: 'Upcoming\nTrial',
              ),
            ),
          ],
        ),
      ),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
        Padding(
            padding: EdgeInsets.all(20.0),
            child: CupertinoButton(
              onPressed: () => {
                Navigator.pushNamed(context, '/communication')
              },
              color: Color(0xff9e7e46),
              //borderRadius: new BorderRadius.circular(30.0),
              child: new Text(
                "Case Detail",
                textAlign: TextAlign.center,
                style: new TextStyle(color: Colors.white),
              ),
            ))
      ]),
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
                    onPressed: () => {Navigator.pushNamed(context, '/payment')},
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
                    onPressed: () => {Navigator.pushNamed(context, '/reviews')},
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
        ]),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text('Latest News', style: TextStyle(fontSize:24))
          ]
      ),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              margin: EdgeInsets.all(15),
              elevation: 10,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Column(
                    children: <Widget>[
                      Image.network(
                          url,
                          fit: BoxFit.cover,
                          height: MediaQuery.of(context).size.width * 0.4
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: Text(title, style: TextStyle(fontSize:16, fontWeight: FontWeight.w600), textAlign: TextAlign.left),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width * 0.8,
                        child: new GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, '/blog');
                          },
                          child: Text('Read more', style: TextStyle(color:Theme.of(context).primaryColor, fontWeight: FontWeight.w600), textAlign: TextAlign.right),

                      ),
                      )]
                  ),
              )
            )
          ],
      )
    ]);
  }
}

class _Child extends StatelessWidget {
  const _Child({
    Key key,
    this.text,
    this.font = 'Roboto',
  }) : super(key: key);
  final String text;
  final String font;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.black12,
      constraints: const BoxConstraints(minWidth: 110, minHeight: 120),
      child: Center(
        child: Text(
          text,
          textAlign: TextAlign.center,
          style: GoogleFonts.getFont(font,
              color: Color(0XFF141035),
              fontWeight: FontWeight.w700,
              fontSize: 14),
        ),
      ),
    );
  }
}
