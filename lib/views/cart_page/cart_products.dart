import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:shopping_app_flutter/domain/product.dart';
import 'package:shopping_app_flutter/views/cart_page/product_item.dart';

class CardProducts extends StatefulWidget {
  final List<ProductItem> products;

  const CardProducts({Key key, this.products}) : super(key: key);
  @override
  _CardProductsState createState() => _CardProductsState();

}

class _CardProductsState extends State<CardProducts> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.products.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return ProductItemWidget(item: widget.products[index],);
      },
    );
  }
}