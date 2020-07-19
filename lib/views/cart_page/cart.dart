import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/models/product.dart';
import 'package:shopping_app_flutter/resource/colors.dart';
import 'package:shopping_app_flutter/views/cart_page/cart_products.dart';
import 'package:shopping_app_flutter/views/cart_page/product_item.dart';

class CartPage extends StatefulWidget {
  final List<ProductItem> products;

  const CartPage({Key key, this.products}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalPrice;
  List<ProductItem> tmp = new List<ProductItem>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print(widget.products.length);
    totalPrice = 0;
    widget.products.forEach((element) {
      totalPrice = totalPrice + element.price*element.qty;
    });
  }

  @override
  Widget build(BuildContext context) {
//    print(totalPrice);
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: mainColor,
        elevation: 0.1,
        title: Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: widget.products.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return ProductItemWidget(
              item: widget.products[index], onSum: (int value) {
            setState(() {
              print(widget.products[index].qty);
              print(value);
              if (widget.products[index].qty < value) {
                totalPrice = totalPrice +  widget.products[index].price;
              } else if (widget.products[index].qty > value) {
                totalPrice = totalPrice - widget.products[index].price;
              }
              widget.products[index].qty = value;
            });
          }, onDelete: () => removeItem(index));
        },
      ),
      bottomNavigationBar: new Container(
        color: Colors.transparent,
        child: Row(
          children: [
            Expanded(
              child: ListTile(
                title: Text('Total: '),
                subtitle: countTotal(totalPrice),
              ),
            ),
            Expanded(
                child: MaterialButton(
                    child: Text(
                      'Pay Now',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: mainColor,
                    onPressed: () => {})),
          ],
        ),
      ),
    );
  }

  Widget countTotal(double totalPrice) {
    setState(() {
      totalPrice = totalPrice;
    });
    print(totalPrice);
    return Text(
      '\$' + totalPrice.roundToDouble().toString(),
      style: TextStyle(
          fontFamily: 'MagnumSansBold', color: mainColor, fontSize: 18.0),
    );
  }
  void removeItem(int index) {
    print('init');
    setState(() {
      widget.products.removeAt(index);
    });
    print('deleted');
  }
}
