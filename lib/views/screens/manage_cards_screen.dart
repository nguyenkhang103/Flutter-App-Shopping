import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app_flutter/provider/user_provider.dart';
import 'package:shopping_app_flutter/resource/colors.dart';

class ManagaCardsScreen extends StatefulWidget {
  @override
  _ManagaCardsScreenState createState() => _ManagaCardsScreenState();
}

class _ManagaCardsScreenState extends State<ManagaCardsScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: mainColor),
          title: Text(
            "Cards",
            style: TextStyle(color: mainColor),
          ),
        ),
        body: ListView.builder(
            itemCount: user.cards.length,
            itemBuilder: (_, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.blueGrey,
                            offset: Offset(2, 1),
                            blurRadius: 5)
                      ]),
                  child: ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text("**** **** **** ${user.cards[index].last4}"),
                    subtitle: Text(
                        "${user.cards[index].month} / ${user.cards[index].year}"),
                    trailing: Icon(Icons.more_horiz),
                    onTap: () {},
                  ),
                ),
              );
            }));
  }
}
