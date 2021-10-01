import 'package:flutter/material.dart';
import '../../../../../style/theme.dart' as Theme;

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: 5,
            child: Container(
              child: Center(
                  child:Text(
                      'Terms of use & Privacy policy',
                  style: TextStyle(fontSize:10))
              )
            )
          ),
          Positioned(
            top: 0,
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  //color: Theme.AppTheme.buttonColor,
                  height: MediaQuery.of(context).size.height * 0.5,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/DC-Immigration-Law-Firm.png"),
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                ),
              ],
            )
          ),
          Padding(
              padding: EdgeInsets.only(top:0.0),
              child: child
          ),
        ],
      ),
    );
  }
}