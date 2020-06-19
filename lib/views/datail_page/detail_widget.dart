import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/domain/product.dart';
import 'package:shopping_app_flutter/resource/colors.dart';

class DetailWidget extends StatefulWidget {
  final ProductItem item;
  const DetailWidget(this.item);
  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  bool isLike;
  @override
  void initState() {
    super.initState();
    this.isLike = false;
  }
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 260,
            decoration: BoxDecoration(
                color: widget.item.itemColor,
                borderRadius:
                    BorderRadius.only(bottomRight: Radius.circular(100))),
            child: Stack(
              children: [
                Center(
                    child: Image.asset(
                  '${widget.item.imagePath}',
                  width: 240,
                )),
                Positioned(
                  left: 25,
                  top: 45,
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      child: Image.asset(
                        'assets/icons/left-arrow.png',
                        color: Colors.blueGrey,
                        width: 20,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 25,
                  top: 35,
                  child: Container(
                    child: Row(
                      children: <Widget>[
                        IconButton(
                          icon: Image.asset(
                            'assets/icons/heart.png',
                            color: this.isLike ?Colors.red : Colors.blueGrey,
                            width: 20,
                          ),
                          onPressed: () {
                            setState(() {
                              this.isLike = !this.isLike;
                            });
                          },
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          'assets/icons/shopping-bag.png',
                          color: Colors.blueGrey,
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          titleWidget(widget.item),
        ],
      ),
    );
  }

  Widget titleWidget(ProductItem item) {
    return Row(
      children: [
        Container(
          width: 8,
          height: MediaQuery.of(context).size.height - 260,
          color: item.itemColor,
        ),
        Container(
          width: MediaQuery.of(context).size.width - 8,
          height: MediaQuery.of(context).size.height - 260,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 60,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        width: 120,
                        child: Text(
                          "${item.title}",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: mainColor,
                              fontSize: 20,
                              fontFamily: 'MagnumSansMedium'),
                        ),
                      ),
                      Positioned(
                          top: 12,
                          right: 0,
                          child: Text(
                            "${item.price}",
                            style: TextStyle(
                                fontSize: 16,
                                color: mainColor,
                                fontFamily: 'MagnumSansBold'),
                          ))
                    ],
                  ),
                ),
                productInfoWidget(item),
                descriptionProductWidget(),
                buttonBuyWidget(),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget productInfoWidget(ProductItem item) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.width / 3 - 23,
      margin: EdgeInsets.only(top: 20),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: item.productInfo.length,
          itemBuilder: (context, int index) {
            return Container(
              margin: EdgeInsets.only(
                  right: index == 0 ? 10 : 0,
                  left: index == item.productInfo.length - 1 ? 10 : 0),
              width: MediaQuery.of(context).size.width / 3 - 23,
              height: MediaQuery.of(context).size.width / 3 - 23,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: mainColor)),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      item.productInfo[index].description,
                      style: TextStyle(fontSize: 9),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Text(
                      item.productInfo[index].title,
                      style:
                          TextStyle(fontFamily: 'MagnumSansBold', fontSize: 12),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Image.asset(
                      item.productInfo[index].imagePath,
                      color: mainColor,
                      width: 32,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  Widget descriptionProductWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Text(
            'Description',
            style: TextStyle(color: mainColor, fontSize: 18),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'An adminitrative division of the Maldives comprising the natural atolls of Felidhu Atoll and the Vattaru Reff. It is the smallest',
            style: TextStyle(color: mainColor, fontSize: 15, height: 1.4),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget buttonBuyWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25), color: mainColor),
      child: Center(
        child: Text(
          'BUY NOW',
          style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontFamily: 'MagnumSansExtraLight'),
        ),
      ),
    );
  }
  void onPressLike() {
    setState(() {
      this.isLike = !this.isLike;
    });
  }
}
