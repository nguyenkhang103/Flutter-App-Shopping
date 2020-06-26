import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/domain/product.dart';
import 'package:shopping_app_flutter/views/datail_page/detail_widget.dart';

class DetailPage extends StatefulWidget {
  final ProductItem item;
  final List<ProductItem> products;
  const DetailPage(this.item, this.products);
  @override
  _DetailPageState createState() => _DetailPageState();

}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
     return Scaffold(
      body: DetailWidget(widget.item, widget.products),
    );
  }

}

