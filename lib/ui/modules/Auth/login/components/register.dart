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
  final loginNameController = new TextEditingController();
  final loginEmailController = new TextEditingController();
  final loginPasswordController = new TextEditingController();
  bool isEnabled = true;
  Map? info;
  Map? data;

  @override
  void dispose() {
    loginNameController.dispose();
    loginEmailController.dispose();
    loginPasswordController.dispose();
    super.dispose();
  }

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
    Size size = MediaQuery.of(context).size;
    return Background(
      child: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.70,
          //height: MediaQuery.of(context).size.height * 0.65,
          height: 400,
          padding: EdgeInsets.all(5.0),
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
          child: Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              //SizedBox(height: size.height * 0.03),
              Positioned(
                  top: 20,
                  child: Image.asset(
                      'assets/img/Motionlaw-logogold-cr.png',
                      width: 220
                  )
              ),
              SizedBox(height: 15),
              Positioned(
                  top: 100,
                  left: 0,
                  right: 0,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                    width: size.width * 0.8,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(29),
                        border: Border.all(color: Colors.black12)
                    ),
                    child: TextField(
                      cursorColor: Theme.Colors.loginGradientButton,
                      controller: loginNameController,
                      decoration: InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        filled: false,
                        fillColor: Colors.blue,
                        icon: Icon(
                            Icons.person,
                            color: Theme.Colors.loginGradientButton
                        ),
                        hintText: 'Full Name',
                        border: InputBorder.none,
                      ),
                    ),
                  )
              ),
              Positioned(
                top: 160,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29),
                      border: Border.all(color: Colors.black12)
                  ),
                  child: TextField(
                    cursorColor: Theme.Colors.loginGradientButton,
                    controller: loginEmailController,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      filled: false,
                      fillColor: Colors.blue,
                      icon: Icon(
                          Icons.email,
                          color: Theme.Colors.loginGradientButton
                      ),
                      hintText: 'Email Address',
                      border: InputBorder.none,
                    ),
                  ),
                )
              ),
              Positioned(
                top: 220,
                left: 0,
                right: 0,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  width: size.width * 0.8,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(29),
                      border: Border.all(color: Colors.black12)
                  ),
                  child: TextField(
                    cursorColor: Theme.Colors.loginGradientButton,
                    controller: loginPasswordController,
                    obscureText: true,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(25.7),
                      ),
                      filled: false,
                      fillColor: Colors.blue,
                      icon: Icon(
                          Icons.lock,
                          color: Theme.Colors.loginGradientButton
                      ),
                      hintText: 'Password',
                      border: InputBorder.none,
                    ),
                  ),
                )
              ),
              Positioned(
                top: 280,
                left: 0,
                right: 0,
                child: RoundedButton(
                  text: isEnabled ? 'Register' : 'Loading...',
                  press: ()=> isEnabled ? register(loginNameController.text, loginEmailController.text, loginPasswordController.text) : null,
                  color: isEnabled ? Theme.Colors.loginGradientButton : Colors.grey,
                  key: _scaffoldKey,
                ),
              ),
              SizedBox(height: 15),
              Positioned(
                top: 360,
                child: new GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "/login");
                  },
                  child: Text('Back to Sign in'),
                )
              ),
              //SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }
}