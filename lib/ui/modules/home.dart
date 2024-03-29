import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:motionlaw/generated/l10n.dart';
import '../../utils/nav-drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:hive/hive.dart';
import '../../utils/constants.dart' as constants;
import '../../services/UpdateInformationDBService.dart';
import '../../services/SlackNotificationService.dart';

bool _hasCases = false;
var responseFuture;
var responseMenu;

List statusCase = [
  {'id':1, 'label':'Assign Cases', 'name': 'Assign Case', 'icon': Text('1', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':2, 'label':'Waiting for\nIntroduction', 'name': 'Waiting for Introduction', 'icon': Text('2', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':3, 'label':'Collecting\nEvidence', 'name': 'Collecting Evidence', 'icon': Text('3', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':4, 'label':'Preparing\nPacket', 'name': 'Preparing Packet', 'icon': Text('4', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':5, 'label':'Attorney\nReview', 'name': 'Attorney Review', 'icon': Text('5', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':6, 'label':'Review and\nSignatures', 'name': 'Review and Signatures', 'icon': Text('6', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':7, 'label':'Filed', 'name': 'Filed', 'icon': Text('7', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':8, 'label':'Pending', 'name': 'Pending', 'icon': Text('8', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':9, 'label':'On Hold', 'name': 'On Hold', 'icon': Text('9', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':10, 'label':'Pending\nPayment', 'name': 'Pending Payment', 'icon': Text('10', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':11, 'label':'Upcoming\nHearing', 'name': 'Upcoming Hearing', 'icon': Text('11', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':12, 'label':'Upcoming\nTrial', 'name': 'Upcoming Trial', 'icon': Text('12', style: TextStyle(color: Colors.black45, fontSize: 20))},
];

List statusCaseSpanish = [
  {'id':1, 'label':'Asignación de\nCaso', 'name': 'Assign Case', 'icon': Text('1', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':2, 'label':'Esperando\nPresentación', 'name': 'Waiting for Introduction', 'icon': Text('2', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':3, 'label':'Recolectando\nEvidencia', 'name': 'Collecting Evidence', 'icon': Text('3', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':4, 'label':'Preparando\nPaquete', 'name': 'Preparing Packet', 'icon': Text('4', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':5, 'label':'En revision de\nAbogado', 'name': 'Attorney Review', 'icon': Text('5', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':6, 'label':'Revision y\nfirmas', 'name': 'Review and Signatures', 'icon': Text('6', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':7, 'label':'Radicado', 'name': 'Filed', 'icon': Text('7', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':8, 'label':'Pendiente', 'name': 'Pending', 'icon': Text('8', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':9, 'label':'En Espera', 'name': 'On Hold', 'icon': Text('9', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':10, 'label':'Pendiente de\nPago', 'name': 'Pending Payment', 'icon': Text('10', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':11, 'label':'Próximo a\nAudiencia', 'name': 'Upcoming Hearing', 'icon': Text('11', style: TextStyle(color: Colors.black45, fontSize: 20))},
  {'id':12, 'label':'Próximo a\nJuicio', 'name': 'Upcoming Trial', 'icon': Text('12', style: TextStyle(color: Colors.black45, fontSize: 20))},
];

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);
  @override
  _HomePageState createState() => new _HomePageState();
}

Future<http.Response> _casesMethod() async {
  try {
    var box = await Hive.openBox('app_data');
    responseFuture = await http
        .get(Uri.parse('${constants.API_BACK_URL}/api/cases'), headers: <String, String>{
      'Accept': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${box.get('token')}'
    });
  } catch (e) {
    SlackNotificationService.sendSlackMessage('Error - home.dart (_casesMethod) : ${e.toString()}');
  }
  return responseFuture;
}

class _HomePageState extends State<HomePage> {

  Future<http.Response> _menu() async {
    try {
      var box = await Hive.openBox('app_data');
      responseMenu = await http
          .get(Uri.parse('${constants.API_BACK_URL}/api/cases'), headers: <String, String>{
        'Accept': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${box.get('token')}'
      });
      final body = json.decode(responseMenu.body);
      if ( body['cases'] != false ) {
        setState(() {
          _hasCases = true;
        });
      }
    } catch (e) {
      print('Error - home.dart (_casesMethod) : ${e.toString()}');
    }
    return responseMenu;
  }

  @override
  void initState() {
    super.initState();
    _menu();
  }

  @override
  void dispose() {
    statusCaseSpanish.clear();
    statusCase.clear();
    responseFuture = null;
    responseMenu = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Text('Motion Law'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: Example8());
  }
}

class Example8 extends StatelessWidget {
  const Example8({Key? key}) : super(key: key);
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

  Future<http.Response> _asyncMethod() async {
    var _responseFuture;
    try {
      var box = await Hive.openBox('app_data');
      await UpdateInformationDBService.updateProfile({'push_token':box.get('push_token')});
      _responseFuture = await http
          .get(Uri.parse('${constants.API_BACK_URL}/blog-list/1/en'), headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer ${box.get('token')}'
      });
    } catch (e) {
      SlackNotificationService.sendSlackMessage('Error - home.dart (_asyncMethod) : ${e.toString()}');
    }
    return _responseFuture;
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
      caseArea(),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
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
                        Text(Translate.of(context).contact_us)
                      ],
                    ),
                    onPressed: () => {Navigator.pushNamed(context, '/chat')},
                  ))),
          (_hasCases == true ) ? Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                  width: 150,
                  child: new CupertinoButton(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: <Widget>[
                        Icon(CupertinoIcons.creditcard, size: 50.0),
                        Text(Translate.of(context).make_payment)
                      ],
                    ),
                    onPressed: () => {Navigator.pushNamed(context, '/payment')},
                  ))) : Container(
              width: 150,
              child: new CupertinoButton(
                padding: EdgeInsets.all(10),
                color: Theme.of(context).primaryColor,
                child: Column(
                  children: <Widget>[
                    Icon(CupertinoIcons.person_2_alt, size: 50.0),
                    Text(Translate.of(context).refer_friend)
                  ],
                ),
                onPressed: () => {Navigator.pushNamed(context, '/refer')},
              )),
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ( _hasCases == true ) ? Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                  width: 150,
                  child: new CupertinoButton(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: <Widget>[
                        Icon(CupertinoIcons.t_bubble, size: 50.0),
                        Text(Translate.of(context).leave_review)
                      ],
                    ),
                    onPressed: () => {Navigator.pushNamed(context, '/reviews')},
                  ))) : SizedBox.shrink(),
          (_hasCases == false ) ? Container() :  Padding(
              padding: EdgeInsets.all(20.0),
              child: Container(
                  width: 150,
                  child: new CupertinoButton(
                    padding: EdgeInsets.all(10),
                    color: Theme.of(context).primaryColor,
                    child: Column(
                      children: <Widget>[
                        Icon(CupertinoIcons.person_2_alt, size: 50.0),
                        Text(Translate.of(context).refer_friend)
                      ],
                    ),
                    onPressed: () => {Navigator.pushNamed(context, '/refer')},
                  ))),
        ]),
      Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new FutureBuilder(
                future: _asyncMethod(),
                builder: (BuildContext context, AsyncSnapshot response) {
                  if ( response.connectionState == ConnectionState.waiting ) {
                    return Align(
                        alignment: Alignment.bottomLeft,
                        child: new Container(
                          height: MediaQuery.of(context).size.height,
                          child: new Center(
                              child: CircularProgressIndicator(
                                value: 0.0,
                                semanticsLabel: 'Linear progress indicator',
                              )
                          ),
                        ));
                  } else if ( response.hasError ) {
                    SlackNotificationService.sendSlackMessage('Error - home.dart (FutureBuilder:178) : ${response.error.toString()}');
                    return Container();
                  } else {
                    Map<String, dynamic> map = json.decode(response.data.body);
                    return Column(
                      children: [
                        Text(Translate.of(context).label_latest_news, style: TextStyle(fontSize:24)),
                        Card(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            margin: EdgeInsets.all(15),
                            elevation: 10,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Column(
                                  children: <Widget>[
                                    Image.network(
                                      map['post_thumbnail'],
                                      fit: BoxFit.cover,
                                      height: MediaQuery.of(context).size.width * 0.4,
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      child: Text(map['post_title'], style: TextStyle(fontSize:16, fontWeight: FontWeight.w600), textAlign: TextAlign.left),
                                    ),
                                    Container(
                                      padding: EdgeInsets.all(10),
                                      width: MediaQuery.of(context).size.width * 0.8,
                                      child: new GestureDetector(
                                        onTap: (){
                                          Navigator.pushNamed(context, '/blog-id',
                                              arguments: {
                                                'id_blog': map['post_id']
                                              });
                                        },
                                        child: Text(Translate.of(context).label_read_more, style: TextStyle(color:Theme.of(context).primaryColor, fontWeight: FontWeight.w600), textAlign: TextAlign.right),

                                      ),
                                    )]
                              ),
                            )
                        )
                      ],
                    );
                  }
                }
            )
          ]
      ),
    ]);
  }
}

class caseArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        child: FutureBuilder(
          future: _casesMethod(),
            builder: (BuildContext context, AsyncSnapshot snapshot){
              if ( snapshot.connectionState == ConnectionState.waiting ) {
                return Align(
                    alignment: Alignment.bottomLeft,
                    child: new Container(
                      //height: MediaQuery.of(context).size.height,
                      height: 100,
                      child: new Center(
                        child: new CupertinoActivityIndicator(),
                      ),
                    ));
              } else if ( snapshot.hasError ) {
                SlackNotificationService.sendSlackMessage('Error - home.dart (FutureBuilder:251) : ${snapshot.error.toString()}');
                return Text('Error');
              } else {
                final body = json.decode(snapshot.data.body);
                if ( body['cases'] != false ){
                  List<dynamic> data = body['cases'];
                  return Column(children: <Widget>[
                    statusCases(data:data),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                      Padding(
                          padding: EdgeInsets.all(20.0),
                          child: CupertinoButton(
                            onPressed: () => {
                              Navigator.pushNamed(context, '/communication')
                            },
                            color: Color(0xff9e7e46),
                            child: new Text(
                              Translate.of(context).button_case_detail,
                              textAlign: TextAlign.center,
                              style: new TextStyle(color: Colors.white),
                            ),
                          ))
                    ])
                  ]);
                } else{
                  return Container();
                }

              }
            })
          );
      }
}

class statusCases extends StatefulWidget {
  const statusCases({
    Key? key,
    @required this.data,
    @required GlobalKey<State<StatefulWidget>>? formKey,
  }) : _formKey = formKey, super(key: key);

  final GlobalKey<State<StatefulWidget>>? _formKey;
  final List<dynamic>? data;

  @override
  _statusCasesState createState() => _statusCasesState();
}

class _statusCasesState extends State<statusCases> {
  final String defaultLocale = Platform.localeName;
  @override
  Widget build(BuildContext context) {
    var query = statusCase.where((row) => (row["name"].contains(widget.data![0]['status'])));
    var swt = defaultLocale.contains('es') ? statusCaseSpanish : statusCase;
    var join = query.first;
    return CupertinoPageScaffold(
      child: Container(
        constraints: const BoxConstraints(maxHeight: 150),
        color: Colors.white,
        child: ListView(
            scrollDirection: Axis.horizontal,
            children: <Widget>[
              for(var item in swt )
                TimelineTile(
                axis: TimelineAxis.horizontal,
                alignment: TimelineAlign.end,
                isFirst: (item['id'] == 1) ? true : false,
                isLast: (item['id'] == 12) ? true : false,
                afterLineStyle: LineStyle(
                  color: ( join['id'] > item['id'] ) ? Colors.green : Colors.black45,
                  thickness: ( join['id'] > item['id'] ) ? 7 : 2,
                ),
                beforeLineStyle: LineStyle(
                  color: ( join['id'] > item['id'] ) ? Colors.green : Colors.black45,
                  thickness: ( join['id'] > item['id'] ) ? 7 : 2,
                ),
                indicatorStyle: IndicatorStyle(
                  width: 40,
                  height: 60,
                  padding: const EdgeInsets.all(8),
                  indicator: Container(
                    decoration: BoxDecoration(
                      color: ( join['id'] > item['id'] ) ? Colors.green : Colors.black12,
                      border: Border.fromBorderSide(
                        BorderSide(
                          color: ( join['id'] > item['id'] ) ? Colors.grey : Colors.black26,
                        ),
                      ),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                        child:
                        ( join['id'] > item['id'] ) ? Icon(CupertinoIcons.check_mark, color: Colors.white, size: 20) : item['icon']),
                  ),
                ),
                startChild: _Child(
                  text: item['label'],
                ),
              )
          ]
        )
      )
    );
  }
}

class _Child extends StatelessWidget {
  const _Child({
    Key? key,
    required this.text,
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
