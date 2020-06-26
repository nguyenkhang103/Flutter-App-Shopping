import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/domain/product.dart';
import 'package:shopping_app_flutter/resource/colors.dart';
import 'package:shopping_app_flutter/views/cart_page/cart_products.dart';

class CartPage extends StatefulWidget {
  final List<ProductItem> products;

  const CartPage({Key key, this.products}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
  
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.products[0].title);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: mainColor,
        elevation: 0.1,
        title: Text('Cart'),
      ),
      body: CardProducts(products: widget.products,),
      bottomNavigationBar: new Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text('Total: '),
                subtitle: Text(''),
              ),
            ),
            Expanded(
              child: MaterialButton(
                  child: Text('Pay Now', style: TextStyle(color: Colors.white),),
                  color: mainColor,
                  onPressed: () =>{})
            ),
          ],
        ),
      ),
    );
  }

}