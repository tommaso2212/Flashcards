import 'dart:io';
import 'package:flutter/material.dart';

class CardSideA extends StatelessWidget {
  final String title;
  final Color color;
  final String image;

  const CardSideA({@required this.title, @required this.color, @required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Container(
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.width * 0.2,
              ),
              child: Image.asset(
                image,
                height: 200,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.2,
              ),
              child: Text(
                title.toUpperCase(),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline4.copyWith(color: Colors.white),
              ),
            ),
            Container(
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.width * 0.2,
              ),
              child: Image.asset(
                "res/images/logo.png",
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
