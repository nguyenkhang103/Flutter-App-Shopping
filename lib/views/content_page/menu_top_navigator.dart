import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopping_app_flutter/models/product.dart';
import 'package:shopping_app_flutter/notifications/snack_bar.dart';
import 'package:shopping_app_flutter/resource/colors.dart';
import 'package:shopping_app_flutter/resource/custom_text.dart';
import 'package:shopping_app_flutter/views/cart_page/cart.dart';

class MenuTopNavigator extends StatefulWidget {
  final List<ProductItem> cartProducts;
  final String name;

  const MenuTopNavigator({Key key, this.cartProducts, this.name})
      : super(key: key);

  @override
  _MenuTopNavigatorState createState() => _MenuTopNavigatorState();
}

class _MenuTopNavigatorState extends State<MenuTopNavigator> {
  FlutterToast flutterToast;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    flutterToast = new FlutterToast(context);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 28),
        margin: EdgeInsets.only(top: 32),
        width: MediaQuery.of(context).size.width,
        height: 64,
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <
                Widget>[
          Row(
            children: <Widget>[
              RichText(
                text: TextSpan(children: [
                  TextSpan(
                      text: 'Hello ',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
                  TextSpan(
                      text: widget.name,
                      style: TextStyle(
                          color: mainColor,
                          fontSize: 20.0,
                          fontWeight: FontWeight.w700)),
                  TextSpan(
                      text: ' !',
                      style: TextStyle(color: Colors.blueGrey, fontSize: 18.0)),
                ]),
              ),
            ],
          ),
          FlatButton(
              padding: EdgeInsets.only(right: 0, top: 8),
              child: Image.asset(
                'assets/icons/shopping-bag.png',
                width: 20,
              ),
              onPressed: () {
                if (widget.cartProducts.isNotEmpty) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CartPage(
                                products: widget.cartProducts,
                              )));
                } else {
                  flutterToast.showToast(
                      child: ToastFailed(
                        title: 'Cart is empty!',
                      ),
                      gravity: ToastGravity.BOTTOM,
                      toastDuration: Duration(milliseconds: 1000));
                }
              }),
        ]));
  }
}
