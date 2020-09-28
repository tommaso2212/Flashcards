import 'package:Flashcards/widget/CustomIcons.dart';
import 'package:flutter/material.dart';

class CardSideA extends StatelessWidget {
  final String definition;
  final Color color;

  CardSideA({@required this.definition, @required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      margin: EdgeInsets.symmetric(
        horizontal: MediaQuery.of(context).size.width * 0.05,
        vertical: MediaQuery.of(context).size.height * 0.05,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.2,
            ),
            child: Icon(
              CustomIcons.vacuumTube,
              color: Colors.white,
              size: MediaQuery.of(context).size.width * 0.3,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.2,
            ),
            child: Text(
              definition.toUpperCase(),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
            ),
          ),
          Container(),
        ],
      ),
    );
  }
}
