import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';

class ImageBanner extends StatefulWidget {
  final List<String> imageList;
  const ImageBanner(this.imageList);
  @override
  _ImageBannerState createState() => _ImageBannerState();
}

class _ImageBannerState extends State<ImageBanner> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        enlargeCenterPage: true,
        height: 180.0,
      ),
      items: widget.imageList.map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                padding: EdgeInsets.only(bottom: 10.0),
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    '$i',
                    fit: BoxFit.cover,
                  ),
                ));
          },
        );
      }).toList(),
    );
  }
}
