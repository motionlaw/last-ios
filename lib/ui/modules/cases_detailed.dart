import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class CasesDetailed extends StatelessWidget {
  //final Cases cases;
  final _formKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    print('Diego Fernando Soba Dominguez $arguments');
    return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          middle: Text('Case Detailed'),
        ),
        child: Scaffold(
            body: SafeArea(
                child: ExpansionTile(
          leading: Icon(CupertinoIcons.archivebox),
          title: Text(
            "D1002-20 Franklin Eduardo Araniva Pastora",
            style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            'Deportation Immigration',
            style: TextStyle(
              fontSize: 12.0,
            ),
          ),
          children: <Widget>[
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              dense: true,
              title: Row(
                children: <Widget>[
                  SizedBox(
                    width: 55,
                  ),
                  Text('ADDED:',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold)),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Text('Dec 7,2019 by Claire Esquivel',
                        style: TextStyle(
                          fontSize: 13.0,
                        )),
                  ),
                ],
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              dense: true,
              title: Row(
                children: <Widget>[
                  SizedBox(
                    width: 55,
                  ),
                  Text('STATUS UPDATE:',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              dense: true,
              title: Row(
                children: <Widget>[
                  SizedBox(
                    width: 55,
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: Text(
                        "NJ sent email to ICE officer reg. Franklin's possible mental illness. Waiting on response. Franklin can be deported any day- he was ordered removed. He asked for deportation when he found out his hearing was going to be continued.",
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.justify,
                        maxLines: 5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              dense: true,
              title: Row(
                children: <Widget>[
                  SizedBox(
                    width: 55,
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.70,
                        child: new GestureDetector(
                          onTap: () {
                            showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoAlertDialog(
                                      title: Text("CASE UPDATE",
                                          style: TextStyle(
                                              fontSize: 13,
                                              fontWeight: FontWeight.w700)),
                                      content: Column(children: <Widget>[
                                        Padding(
                                          padding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 20),
                                          child: Text(
                                              'Please type the complete message of new update in this case.',
                                              style: TextStyle(
                                                fontSize: 12.0,
                                              )),
                                        ),
                                        Builder(
                                          builder: (context) => Form(
                                              key: _formKey,
                                              child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .stretch,
                                                  children: [
                                                    CupertinoTextField(
                                                      keyboardType:
                                                          TextInputType
                                                              .multiline,
                                                      placeholder: "Message",
                                                      onChanged: (value) {
                                                        if (value.isEmpty) {
                                                          return 'Please enter a valid message';
                                                        }
                                                      },
                                                    ),
                                                  ])),
                                        )
                                      ]),
                                      actions: [
                                        CupertinoDialogAction(
                                            child: Text('Close'),
                                            onPressed: () =>
                                                Navigator.pop(context)),
                                        CupertinoDialogAction(
                                            child: Text('Save'),
                                            onPressed: () =>
                                                Navigator.pop(context)),
                                      ],
                                    ));
                          },
                          child: new Text("Add new update",
                              style: TextStyle(
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue),
                              textAlign: TextAlign.right),
                        )),
                  ),
                ],
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              dense: true,
              title: Row(
                children: <Widget>[
                  SizedBox(
                    width: 55,
                  ),
                  Text('CASE BILLING INFORMATION:',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12.0,
                          fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            ListTile(
              visualDensity: VisualDensity(horizontal: 0, vertical: -4),
              dense: true,
              title: Row(
                children: <Widget>[
                  SizedBox(
                    width: 50,
                  ),
                  Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      width: MediaQuery.of(context).size.width * 0.70,
                      child: DataTable(
                        columns: [
                          DataColumn(label: Text('Number')),
                          DataColumn(label: Text('Total')),
                          DataColumn(label: Text('Status'))
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(Text('00252')),
                            DataCell(Text('\$2.000,00')),
                            DataCell(Icon(CupertinoIcons.checkmark_square,
                                color: Colors.green))
                          ]),
                          DataRow(cells: [
                            DataCell(Text('00113')),
                            DataCell(Text('\$3.000,00')),
                            DataCell(
                                Icon(CupertinoIcons.creditcard,
                                    color: Colors.blue), onTap: () {
                              _launchURL();
                            })
                          ]),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ))));
  }
}

_launchURL() async {
  const url = 'https://motion-law.mycase.com/xa7n7str';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}
