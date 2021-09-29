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
                  height: 300,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/img/DC-Immigration-Law-Firm.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            )
          ),
          Padding(
              padding: EdgeInsets.only(top:100),
              child: child
          ),
        ],
      ),
    );
  }
}