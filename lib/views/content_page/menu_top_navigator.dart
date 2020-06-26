import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/domain/product.dart';
import 'package:shopping_app_flutter/views/cart_page/cart.dart';

class MenuTopNavigator extends StatefulWidget {
  final List<ProductItem> cartProducts;

  const MenuTopNavigator({Key key, this.cartProducts}) : super(key: key);
  @override
  _MenuTopNavigatorState createState() => _MenuTopNavigatorState();
}

class _MenuTopNavigatorState extends State<MenuTopNavigator> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 28),
        margin: EdgeInsets.only(top: 32),
        width: MediaQuery.of(context).size.width,
        height: 64,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          FlatButton(
            padding: EdgeInsets.only(left: 0,top: 22),
            child: Image.asset(
              'assets/icons/menu.png',
              width: 20,
            ),
          ),
          FlatButton(
            padding: EdgeInsets.only(right: 0,top: 22),
            child: Image.asset(
              'assets/icons/shopping-bag.png',
              width: 20,
            ),
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => CartPage(products: widget.cartProducts,))),
          ),
        ]));
  }
}
