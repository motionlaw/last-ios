import 'package:flutter/material.dart';
import 'text_field_container.dart';
import '../../../../../style/theme.dart' as Theme;

class RoundedPasswordField extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final ValueChanged<String> onChanged;
  final String hintText;

  RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required TextEditingController controller,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      key: _scaffoldKey,
      child: TextField(
        obscureText: true,
        onChanged: onChanged,
        //cursorColor: Theme.AppTheme.primaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          icon: Icon(
            Icons.lock,
            color: Theme.Colors.loginGradientButton
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}