import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../components/rounded_button.dart';
import '../../../components/rounded_input_field.dart';
import '../../../components/rounded_password_field.dart';
import '../../../../../utils/Functions.dart' as tool;
import '../../../../../style/theme.dart' as Theme;
import 'background.dart';
import '../../../../../utils/constants.dart' as constants;
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);
  @override
  _LoginState createState() => new _LoginState();
}

class _LoginState extends State<Register>
  with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController loginNameController = new TextEditingController();
  TextEditingController loginEmailController = new TextEditingController();
  TextEditingController loginPasswordController = new TextEditingController();
  bool isEnabled = true;
  Map? info;
  Map? data;

  Future register(String username, String mail, String pass) async {
    if( username == '' || mail == '' || pass == '' ){
      _handleClickMe('Fields required', 'Please complete information');
    } else {
      if (tool.Functions.validateEmail(mail)) {
        try {
          setState(() {
            isEnabled = false;
          });
          http.Response response = await http.post(
              Uri.parse('${constants.API_BACK_URL}/api/register'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              },
              body: jsonEncode(<String, String>{'username': username, 'email': mail, 'password': pass}));
          data = json.decode(response.body);
          print('Respuesta de registro :: ${data}');
          if (data!['response'] == true) {
            _handleClickMe('User created successfully', 'A confirmation message has been sent to email registered, please validate your account before continue');
            setState(() {
              isEnabled = true;
            });
          } else {
            _handleClickMe('Data Invalid', 'The user is already created');
            setState(() {
              isEnabled = true;
            });
          }
        } catch (e) {
          print('Error - register.dart (auth) : ${e.toString()}');
        }
        return data!['response'];
      } else {
        _handleClickMe('Email incorrect', 'Email is invalid');
      }
    }
  }

  Future<void> _handleClickMe(title, message) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text(message),
          actions: <Widget>[
            CupertinoDialogAction(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.70,
          height: MediaQuery.of(context).size.height * 0.65,
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              //SizedBox(height: size.height * 0.03),
              Positioned(
                  top: 0,
                  left: 0,
                  child: Image.asset(
                      'assets/img/Motionlaw-logogold-cr.png',
                      width: 220
                  )
              ),
              SizedBox(height: 15),
              RoundedInputField(
                icon: Icons.person,
                hintText: 'Full Name',
                controller: loginNameController,
                onChanged: (value) {
                  loginNameController.text = value.trim();
                },
              ),
              RoundedInputField(
                icon: Icons.email,
                hintText: 'Email Address',
                controller: loginEmailController,
                onChanged: (value) {
                  loginEmailController.text = value.trim();
                },
              ),
              RoundedPasswordField(
                controller: loginPasswordController,
                onChanged: (value) {
                  loginPasswordController.text = value.trim();
                },
                hintText: 'Password',
              ),
              RoundedButton(
                text: isEnabled ? 'Register' : 'Loading...',
                press: ()=> isEnabled ? register(loginNameController.text, loginEmailController.text, loginPasswordController.text) : null,
                color: isEnabled ? Theme.Colors.loginGradientButton : Colors.grey,
                key: _scaffoldKey,
              ),
              SizedBox(height: 15),
              new GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/login");
                },
                child: Text('Login using email address'),
              )
              //SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}