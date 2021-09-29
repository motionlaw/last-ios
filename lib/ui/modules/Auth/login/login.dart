import 'package:flutter/material.dart';
import 'components/body.dart';
import 'package:hive/hive.dart';

class LoginScreen extends StatelessWidget {
  @override

  checkStatus() async {
    var box = await Hive.openBox('app_data');
    if (box.get('token') != null) {
      return true;
    } else {
      return false;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Login(),
    );
  }
}