import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../style/theme.dart' as Theme;
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:flutter_html/flutter_html.dart';
import '../../services/SlackNotificationService.dart';

Map? arguments;
var url;

class BlogIdPage extends StatefulWidget {
  BlogIdPage({Key? key}) : super(key: key);
  @override
  _BlogPageState createState() => new _BlogPageState();
}

Future<http.Response> _asyncMethod(context) async {
  var _responseFuture;
  try{
    var box = await Hive.openBox('app_data');
    arguments = await ModalRoute.of(context)?.settings.arguments as Map;

    if ( arguments != null) {
      url = 'https://qqv.oex.mybluehost.me/blog-id/${arguments?['id_blog']}';
    }

    _responseFuture = await http
        .get(Uri.parse(url), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer ${box.get('token')}'
    });
  } catch (e){
    SlackNotificationService.sendSlackMessage('blog_id.dart : _asyncMethod() - ${e.toString()}');
  }
  return _responseFuture;
}

class _BlogPageState extends State<BlogIdPage>
    with SingleTickerProviderStateMixin {

  @override
  void initState() {
    super.initState();
  }

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
            body: FutureBuilder(
                future: _asyncMethod(context),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if ( snapshot.connectionState == ConnectionState.waiting ) {
                    return Align(
                        alignment: Alignment.bottomLeft,
                        child: new Container(
                          height: MediaQuery.of(context).size.height * 0.9,
                          child: new Center(
                            child: new CupertinoActivityIndicator(),
                          ),
                        ));
                  } else {
                    Map<String, dynamic> map = json.decode(snapshot.data.body);
                    print('Ejemplo : ${map['post_content']}');
                    final List<Widget> items = List.generate(1, (i) => Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Container(
                          width: double.infinity,
                          child: Html(
                            data: (map == null) ? map['post_content'] : map['post_content'],
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
                                      (map == null) ? map['post_thumbnail'] : map['post_thumbnail'],
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