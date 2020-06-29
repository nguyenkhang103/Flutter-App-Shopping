import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_app_flutter/domain/product.dart';
import 'package:shopping_app_flutter/views/cart_page/product_item.dart';

class CardProducts extends StatefulWidget {
  final List<ProductItem> products;
  var totalPrice;

   CardProducts({Key key, this.products, this.totalPrice})
      : super(key: key);

  @override
  _CardProductsState createState() => _CardProductsState();

}

class _CardProductsState extends State<CardProducts> {
  double sum = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sum = widget.totalPrice;
  }
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ProductItemWidget(
            item: widget.products[index], onSum: (int value) {
          setState(() {
            widget.products[index].qty = value;
            sum = sum + widget.products[index].qty * widget.products[index].price;
            widget.totalPrice = sum;
            print(widget.totalPrice);
          });
        }, onDelete: () => removeItem(index));
      },
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