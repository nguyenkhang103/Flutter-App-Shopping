import 'package:flutter/material.dart';

class Product {
  bool isSelected;
  String title;
  String imgUrl;
  List<ProductItem> productItem = [];
  List<String> images = [];
  Product(this.isSelected,this.title, this.imgUrl, this.productItem,{this.images});
}
class ProductItem {
  String type;
  bool isSelected;
  Color itemColor;
  String imagePath;
  String price;
  String title;
  String brand;
  List<ProductInfo> productInfo = [];
  ProductItem(this.type,this.isSelected,this.itemColor,this.imagePath,this.price,this.title,this.brand,{this.productInfo});
}
class ProductInfo {
  String description;
  String title;
  String imagePath;
  ProductInfo(this.description,this.title,this.imagePath);
}