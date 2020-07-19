import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/models/product.dart';
import 'package:shopping_app_flutter/resource/colors.dart';

class MenuItem extends StatelessWidget {
  final Product _item;

  const MenuItem(this._item);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: _item.isSelected ? mainColor.withOpacity(0.7) : Colors.transparent,
            blurRadius: 20,
            offset: Offset(0.0, 8.0)),
        ],
        borderRadius: BorderRadius.circular(32),
        color: _item.isSelected ? mainColor : menuColor,
      ),
      child: Center(
        child: Image.asset(
          _item.imgUrl,
          color: _item.isSelected ? Colors.white : mainColor,
          width: 32,
        ),
      ),
    );
  }
}
