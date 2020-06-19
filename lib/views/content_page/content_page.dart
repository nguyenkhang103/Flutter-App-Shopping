import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/views/content_page/menu_header.dart';
import 'package:shopping_app_flutter/views/content_page/menu_product_navigator.dart';
import 'package:shopping_app_flutter/views/content_page/menu_top_navigator.dart';

class ContentPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MenuHeader(),
        MenuTopNavigator(),
        MenuProductNavigator(),
      ],
    );
  }

}
