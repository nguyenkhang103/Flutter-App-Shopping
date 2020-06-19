import 'package:flutter/cupertino.dart';
import 'package:shopping_app_flutter/resource/colors.dart' as color;

class MenuHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
   return Container(
     width: MediaQuery.of(context).size.width,
     height: 8,
     color: color.mainColor,
   );
  }

}