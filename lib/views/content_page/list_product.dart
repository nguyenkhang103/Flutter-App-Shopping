import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/domain/product.dart';
import 'package:shopping_app_flutter/resource/colors.dart';
import 'package:shopping_app_flutter/views/datail_page/detail_page.dart';

class ListProduct extends StatefulWidget {
  final List<ProductItem> listProductIteam;
  final List<ProductItem> cartProducts;

  const ListProduct(this.listProductIteam, this.cartProducts);

  @override
  _ListProductState createState() => _ListProductState();
}

class _ListProductState extends State<ListProduct> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
          itemCount: widget.listProductIteam.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, int index) {
            return Padding(
                padding: EdgeInsets.only(
                    left: index == 0 ? 32 : 0, top: 0, bottom: 16),
                child: Row(
                  children: <Widget>[
                    new InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (contetx) => DetailPage(
                                    widget.listProductIteam[index], widget.cartProducts)));
                      },
                      splashColor: widget.listProductIteam[index].itemColor,
                      child: Row(
                        children: <Widget>[
                          productCard(widget.listProductIteam[index]),
                          SizedBox(
                            width: 24,
                          )
                        ],
                      ),
                    )
                  ],
                ));
          }),
    );
  }

  Widget productCard(ProductItem item) {
    return Container(
      height: 260,
      width: MediaQuery.of(context).size.width * 0.45,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5),
              topRight: Radius.circular(5),
              bottomLeft: Radius.circular(5),
              bottomRight: Radius.circular(50)),
          color: item.itemColor,
          boxShadow: [
            BoxShadow(
                color: item.isSelected
                    ? mainColor.withOpacity(0.7)
                    : Colors.transparent,
                blurRadius: 20,
                offset: Offset(0.0, 8.0))
          ]),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Center(
                child: Image.asset(
                  item.imagePath,
                  width: 156,
                  height: 156,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    item.price,
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  )),
              SizedBox(
                height: 4,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    item.title,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold),
                  )),
              SizedBox(
                height: 4,
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  child: Text(
                    item.brand,
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  )),
            ],
          ),
          Positioned(
            child: FlatButton(
              child: Icon(
                Icons.add_circle,
                color: Colors.white,
              ),
              onPressed: () {
                widget.cartProducts.add(item);
              },
            ),
            right: -5.0,
            bottom: 5.0,
          ),
        ],
      ),
    );
  }
}
