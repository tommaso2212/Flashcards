import 'package:Flashcards/data/model/Card.dart';
import 'package:Flashcards/utils/BoxUtils.dart';
import 'package:flutter/widgets.dart';

class TestCard extends Card {
  Color color;

  TestCard({
    int id,
    String setTitle,
    String definition,
    String description,
    Boxes box,
    DateTime lastTimeUsed,
    this.color,
  }) : super(
          id: id,
          setTitle: setTitle,
          definition: definition,
          description: description,
          box: box,
          lastTimeUsed: lastTimeUsed,
        );

  factory TestCard.fromCard(Card element, Color color) {
    return TestCard(
      id: element.id,
      setTitle: element.setTitle,
      definition: element.definition,
      description: element.description,
      box: element.box,
      lastTimeUsed: element.lastTimeUsed,
      color: color,
    );
  }
}
