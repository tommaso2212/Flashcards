import 'package:Flashcards/data/model/Card.dart';

class Set {
  final int id;
  final String title;
  final String color;
  List<Card> cards;

  Set({this.id, this.title, this.color});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'color': color,
    };
  }
}