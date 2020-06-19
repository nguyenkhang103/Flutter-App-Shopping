import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/views/content_page/content_page.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowMaterialGrid: false,
      title: 'K&V Store', 
      home: HomeScreen(),
    );
  }

}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ContentPage(),
    );
  }

}



