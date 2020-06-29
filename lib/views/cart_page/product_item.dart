import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shopping_app_flutter/domain/product.dart';
import 'package:shopping_app_flutter/resource/colors.dart';

class ProductItemWidget extends StatefulWidget {
  final ProductItem item;
  final VoidCallback onDelete;
  final Function  onSum;
  ProductItemWidget({Key key, this.item, this.onDelete, this.onSum}) : super(key: key);
  @override
  _ProductItemWidgetState createState() => _ProductItemWidgetState();

}

class _ProductItemWidgetState extends State<ProductItemWidget>{
  int _qyt = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _qyt = widget.item.qty;
  }
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding: EdgeInsets.only(top:0.0),
        leading: Image.asset(widget.item.imagePath,width:80.0,height: 100.0,),
        title: Text(widget.item.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('Brand: '),
                Text(widget.item.brand, style: TextStyle(color: mainColor,fontFamily: 'MagnumSansBold',),),
              ],
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Text('\$'+widget.item.price.toString(), style: TextStyle(color: mainColor,fontFamily: 'MagnumSansBold',fontSize: 18.0),),
            ),
          ],
        ),
        trailing: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(child: IconButton(icon: Icon(Icons.arrow_drop_up),padding: EdgeInsets.only(bottom: 2.0),onPressed: (){
              setState(() {
                _qyt++;
//                widget.item.qty = _qyt;
//                widget.totalPrice = widget.item.price * _qyt;
//                print(widget.item.qty);
              widget.onSum(_qyt);
              });
            })),
            Expanded(child: Text(_qyt.toString())),
            Expanded(child: IconButton(icon: Icon(Icons.arrow_drop_down),padding: EdgeInsets.only(top:0.5),onPressed: () {
              setState(() {
               _qyt > 0 ? _qyt-- : {};
//               widget.item.qty = _qyt;
               widget.onSum(_qyt);
//               widget.totalPrice = widget.item.price * _qyt;
//               print(widget.totalPrice);
//              widget.onSum;
              });
            })),
          ],
        ),
        onLongPress: widget.onDelete,
      ),
    );
  }
}