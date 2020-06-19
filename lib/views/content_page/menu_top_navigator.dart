import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuTopNavigator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 28),
        margin: EdgeInsets.only(top: 32),
        width: MediaQuery.of(context).size.width,
        height: 64,
        child: Stack(children: <Widget>[
          Positioned(
              left: 0,
              top: 22,
              child: Image.asset(
                'assets/icons/menu.png',
                width: 20,
              )),
          Positioned(
              right: 0,
              top: 22,
              child: Image.asset(
                'assets/icons/shopping-bag.png',
                width: 20,
              )),
        ]));
  }
}
