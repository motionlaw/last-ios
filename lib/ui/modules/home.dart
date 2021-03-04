import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../utils/nav-drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';

Map data;

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

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => new _HomePageState();
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
        body: Example8());
  }
}

class Example8 extends StatelessWidget {
  const Example8({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        constraints: const BoxConstraints(maxHeight: 180),
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
                          Icon(CupertinoIcons.check_mark, color: Colors.white)),
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
                          Icon(CupertinoIcons.check_mark, color: Colors.white)),
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
                        fontSize: 30,
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
                        fontSize: 30,
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
                        fontSize: 30,
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
                        fontSize: 30,
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
                        fontSize: 30,
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
                        fontSize: 30,
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
                        fontSize: 30,
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
                        fontSize: 30,
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
                        fontSize: 30,
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
                        fontSize: 30,
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
              onPressed: () => {},
              color: Colors.orange,
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
        ],
      ),
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
