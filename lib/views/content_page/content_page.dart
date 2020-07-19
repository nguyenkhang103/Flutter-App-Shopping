import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/models/product.dart';
import 'package:shopping_app_flutter/provider/user_provider.dart';
import 'package:shopping_app_flutter/resource/custom_text.dart';
import 'package:shopping_app_flutter/views/content_page/menu_header.dart';
import 'package:shopping_app_flutter/views/content_page/menu_product_navigator.dart';
import 'package:shopping_app_flutter/views/content_page/menu_top_navigator.dart';
import 'package:shopping_app_flutter/views/screens/credit_card_screen.dart';
import 'package:shopping_app_flutter/views/screens/manage_cards_screen.dart';

class ContentPage extends StatefulWidget {
  final UserProvider user;

  const ContentPage({Key key, this.user}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  final List<ProductItem> cartProducts = List<ProductItem>();

  @override
  Widget build(BuildContext context) {
    print(widget.user.userModel.username);
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountEmail: CustomText(
                msg: widget.user.user.email,
                color: Colors.white,
              ),
              accountName: CustomText(
                msg: widget.user.userModel.username != null ? widget.user.userModel.username : 'Anonymous',
                color: Colors.white,
              ),
            ),
            ListTile(
              leading: Icon(Icons.add),
              title: CustomText(
                msg: "Add Credit Card",
              ),
              onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => CreditCard(title: 'Add Card',)));
              },
            ),
            ListTile(
              leading: Icon(Icons.credit_card),
              title: CustomText(
                msg: "Manage Cards",
              ),
              onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => ManagaCardsScreen()));
              },
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: CustomText(
                msg: "Purchase history",
              ),
              onTap: () {
//                  changeScreen(context, Purchases());
              },
            ),
            ListTile(
              leading: Icon(Icons.memory),
              title: CustomText(
                msg: "Subscriptions",
              ),
              onTap: () {
//                  changeScreen(context, ManagaCardsScreen());
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: CustomText(
                msg: "Log out",
              ),
              onTap: () {
                widget.user.signOut();
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          MenuHeader(),
          MenuTopNavigator(
            name: widget.user.userModel.username,
            cartProducts: cartProducts,
          ),
          MenuProductNavigator(
            cartProducts: cartProducts,
          ),
        ],
      ),
    );
  }
}
