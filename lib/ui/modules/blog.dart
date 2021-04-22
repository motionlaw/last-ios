import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../style/theme.dart' as Theme;
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:flutter_html/flutter_html.dart';

class BlogPage extends StatefulWidget {
  BlogPage({Key key}) : super(key: key);
  @override
  _BlogPageState createState() => new _BlogPageState();
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

class _BlogPageState extends State<BlogPage>
  with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

  final List <Color> colores = [
    Colors.red,
    Colors.orange,
    Colors.pink,
    Colors.amber,
    Colors.lime,
  ];

  @override
  Widget build(BuildContext context) {
    var rnd = new Random();
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Blog', style: TextStyle(
            color: Colors.white,
          ),),
          backgroundColor: Theme.Colors.loginGradientButton,
          previousPageTitle: 'Back',
        ),
        child: Scaffold(
          //backgroundColor: Colors.white,
          body: FutureBuilder(
              future: _asyncMethod(),
              builder: (BuildContext context, AsyncSnapshot snapshot){
                if ( snapshot.connectionState == ConnectionState.waiting ) {
                  return Align(
                      alignment: Alignment.bottomLeft,
                      child: new Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: new Center(
                          child: new CupertinoActivityIndicator(),
                        ),
                      ));
                } else {
                  Map<String, dynamic> map = json.decode(snapshot.data.body);
                  final List<Widget> items = List.generate(1, (i) => Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Container(
                        width: double.infinity,
                        child: Html(
                          data: map['data']['post_content'],
                        )
                    ),
                  ));
                  return SafeArea(
                    child: CustomScrollView(
                        slivers: <Widget>[
                          SliverAppBar(
                              automaticallyImplyLeading: false,
                              floating: true,
                              pinned: true,
                              expandedHeight: 200,
                              flexibleSpace: Image.network(
                                  map['data']['post_thumbnail'],
                                  fit: BoxFit.cover
                              )
                          ),
                          SliverList(
                              delegate: SliverChildListDelegate(items)
                          )
                        ]
                    )
                  );
                }
              }
          )
        )
    );
  }
}