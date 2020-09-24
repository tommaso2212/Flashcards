import 'package:Flashcards/data/model/Card.dart';

class Set {
  final String title;
  final String color;
  List<Card> cards;

  Set({this.title, this.color, this.cards});

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'color': color,
    };
  }

  factory Set.fromJson(Map<String, dynamic> json) {
    return Set(
      title: json['title'] as String,
      color: json['color'] as String,
      cards: (json['cards'] as List).map((e) => Card.fromJson(e)).toList(),
    );
  }
}
