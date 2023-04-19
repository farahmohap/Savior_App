import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class CarouselSliderr extends StatelessWidget {
  const CarouselSliderr({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
        options: CarouselOptions(
            height: 200.0, autoPlay: true, viewportFraction: 0.97),
        items: <Widget>[carousalContent( "images/band1.png"),
        carousalContent( "images/girls.jpg"),
        carousalContent( "images/c3.jpg"),
        carousalContent( "images/c1.jpg"),
        carousalContent( "images/c4.jpg"),
        carousalContent( "images/c2.jpg"),
        carousalContent( "images/bandd.jpg"),
        carousalContent( "images/band3.jpg")]
        );
  }

  Builder carousalContent(String Url) {
    return Builder(builder: (BuildContext context) {
      return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.symmetric(horizontal: 5),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25),
          child: Image.asset(
            Url,
            fit: BoxFit.fill,
          ),
        ),
      );
    });
  }
}
