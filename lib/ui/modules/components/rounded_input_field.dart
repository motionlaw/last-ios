import 'package:flutter/material.dart';
import 'text_field_container.dart';
import '../../../../../style/theme.dart' as Theme;

class RoundedInputField extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final String hintText;
  final IconData icon;
  final ValueChanged<String> onChanged;
  RoundedInputField({
    Key? key,
    required this.hintText,
    required this.icon,
    required this.onChanged,
    required TextEditingController controller,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      key: _scaffoldKey,
      child: TextField(
        //onChanged: onChanged,
        //cursorColor: Theme.AppTheme.primaryColor,
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(25.7),
          ),
          //filled: false,
          fillColor: Colors.blue,
          /*icon: Icon(
            icon,
            color: Theme.Colors.loginGradientButton
          ),*/
          //hintText: hintText,
          border: InputBorder.none,
        ),
      ),
    );
  }
}