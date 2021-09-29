import 'package:flutter/material.dart';
import '../../../../../style/theme.dart' as Theme;

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  const TextFieldContainer({
    required Key key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      width: size.width * 0.8,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(29),
        border: Border.all(color: Colors.black12)
      ),
      child: child,
    );
  }
}