import 'package:flutter/material.dart';
import 'package:shopping_app_flutter/models/product.dart';
import 'package:shopping_app_flutter/resource/colors.dart';
import 'package:shopping_app_flutter/views/content_page/image_banner.dart';
import 'package:shopping_app_flutter/views/content_page/list_product.dart';
import 'package:shopping_app_flutter/views/content_page/menu_item.dart';

class MenuProductNavigator extends StatefulWidget {
  final List<ProductItem> cartProducts;

  const MenuProductNavigator({Key key, this.cartProducts}) : super(key: key);
  @override
  _MenuProductNavigatorState createState() => _MenuProductNavigatorState();
}

class _MenuProductNavigatorState extends State<MenuProductNavigator> {
  List<Product> listPro = new List<Product>();
  List<ProductItem> listTmp = new List<ProductItem>();
  List<ProductInfo> infosTmp = new List<ProductInfo>();
  List<ProductItem> listProductClock = new List<ProductItem>();
  List<ProductItem> listProductLamp = new List<ProductItem>();
  List<ProductItem> listProductSofa = new List<ProductItem>();
  List<ProductItem> listProductTable = new List<ProductItem>();
  List<String> images = new List<String>();
  List<String> imagesWatch = new List<String>();
  List<String> imagesLamp = new List<String>();
  String title;
  @override
  void initState() {
    super.initState();
    listProductClock.add(new ProductItem(
        'Watch',
        true,
        mainColor,
        'assets/products/watch-1.png',
        1000.99,
        "Rado D-Star 200",
        "Rolex", productInfo: this.infosTmp));
    listProductClock.add(new ProductItem('Watch', true, secondColor,
        'assets/products/watch-2.png', 999.99, "Gaz-14", "Rolex",productInfo: this.infosTmp));
    listProductLamp.add(new ProductItem(
        'Lamp',
        true,
        mainColor,
        'assets/products/hanginglight.png',
        425.8,
        "Hanging Light",
        "Fab Interia",productInfo: this.infosTmp));
    listProductLamp.add(new ProductItem(
        'Lamp',
        true,
        secondColor,
        'assets/products/desklamp.png',
        329.5,
        "Desk Lamp",
        "HMVPL",productInfo: this.infosTmp));
    listProductSofa.add(new ProductItem('Sofa', true, mainColor,
        'assets/products/sofa-1.png', 250.99, "Sofa Bed", "ZSofa",productInfo: this.infosTmp));
    listProductSofa.add(new ProductItem('Sofa', true, secondColor,
        'assets/products/sofa-2.png', 379.99, "Sofa Bed", "ZSofa",productInfo: this.infosTmp));
    listProductSofa.add(new ProductItem(
        'Sofa',
        true,
        thirdColor,
        'assets/products/sofa-3.png',
        145.25,
        "Sofa Armchair",
        "ZSofa",productInfo: this.infosTmp));
    listProductTable.add(new ProductItem('Table', true, mainColor,
        'assets/products/table-1.png', 102.8, "Table Cafe", "AGO",productInfo: this.infosTmp));
    listProductTable.add(new ProductItem(
        'Table',
        true,
        secondColor,
        'assets/products/table-2.png',
        118.5,
        "Rivermead Cafe",
        "Rivermead",productInfo: this.infosTmp));
    listProductTable.add(new ProductItem(
        'Table',
        true,
        thirdColor,
        'assets/products/table-3.png',
        120,
        "Table Work",
        "Go Home",productInfo: this.infosTmp));
    listPro.add(new Product(
        true, 'Watch', 'assets/icons/clock.png', this.listProductClock,
        images: this.imagesWatch));
    listPro.add(new Product(
        false, 'Sofa', 'assets/icons/sofa.png', this.listProductSofa,
        images: []));
    listPro.add(new Product(
        false, 'Table', 'assets/icons/table.png', this.listProductTable,
        images: []));
    listPro.add(new Product(
        false, 'Lamp', 'assets/icons/lamp.png', this.listProductLamp,
        images: this.imagesLamp));
    imagesLamp.add("assets/img/ac1.jpg");
    imagesLamp.add("assets/img/ac3.jpg");
    imagesLamp.add("assets/img/ac4.jpg");
    imagesLamp.add("assets/img/ac2.jpg");
    imagesWatch.add('assets/img/ac5.jpg');
    imagesWatch.add('assets/img/ac6.jpg');
    infosTmp.add(new ProductInfo("In a matter of min", "Easy Install", "assets/icons/clock.png"));
    infosTmp.add(new ProductInfo("Bridge Included", "Ambiance", "assets/icons/idea.png"));
    infosTmp.add(new ProductInfo("Available different", "Color", "assets/icons/paint-palette.png"));
    listPro.forEach((element) {
      if (element.isSelected == true) {
        this.title = element.title;
        this.listTmp = element.productItem;
        this.images = element.images;
      } else {
        print('No data');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - 104,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            categoryWidget(),
            titleBar(),
            ListProduct(listTmp,widget.cartProducts),
            imageBannerTitleWidget(),
            ImageBanner(images),
            //  CarouselMenu()
          ],
        ),
      ),
    );
  }

  Widget categoryWidget() {
    return Container(
      height: 96,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          itemCount: listPro.length,
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context, int index) {
            return Padding(
              padding: EdgeInsets.only(
                  left: index == 0 ? 42 : 0, top: 0, bottom: 12),
              child: Row(
                children: [
                  InkWell(
                    splashColor: mainColor,
                    borderRadius: BorderRadius.circular(32),
                    onTap: () => {
                      setState(() {
                        listPro.forEach((element) {
                          element.isSelected = false;
                        });
                        listPro[index].isSelected = true;
                        this.title = listPro[index].title;
                        this.listTmp = listPro[index].productItem;
                        this.images = listPro[index].images.isNotEmpty
                            ? listPro[index].images
                            : [];
                      })
                    },
                    child: MenuItem(listPro[index]),
                  ),
                  SizedBox(
                    width: 22,
                  ),
                ],
              ),
            );
          }),
    );
  }

  Widget titleBar() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      child: Stack(
        children: <Widget>[
          new RichText(
              text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                new TextSpan(
                    text: this.title,
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                        fontFamily: 'MagnumSansMedium')),
              ])),
          seeAllButton()
        ],
      ),
    );
  }

  Widget seeAllButton() {
    return Positioned(
      right: 0,
      child: InkWell(
        child: Row(
          children: <Widget>[
            Text(
              'See All',
              style: TextStyle(fontSize: 12.0, color: mainColor),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: mainColor,
            )
          ],
        ),
      ),
    );
  }

  Widget imageBannerTitleWidget() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 64,
      padding: EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      child: Stack(
        children: <Widget>[
          new RichText(
              text: new TextSpan(
                  style: new TextStyle(
                    fontSize: 20.0,
                    color: Colors.black,
                  ),
                  children: <TextSpan>[
                new TextSpan(
                    text: 'Image - ',
                    style: new TextStyle(
                        fontWeight: FontWeight.bold,
                        color: mainColor,
                        fontFamily: 'MagnumSansMedium')),
                new TextSpan(
                    text: this.title,
                    style: new TextStyle(
                        fontWeight: FontWeight.normal,
                        color: mainColor,
                        fontFamily: 'MagnumSansExtraLight')),
              ])),
        ],
      ),
    );
  }
}
