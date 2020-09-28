import 'package:Flashcards/utils/BoxUtils.dart';

class Card {
  final int id;
  final String setTitle;
  final String definition;
  final String description;
  Boxes box;
  DateTime lastTimeUsed;

  Card({this.id, this.setTitle, this.definition, this.description, this.box, this.lastTimeUsed,});

  Map<String, dynamic> toMap() {
    return {
      'setTitle': setTitle,
      'definition': definition,
      'description': description,
      'box': box.index,
      'lastTimeUsed': lastTimeUsed.toIso8601String(),
    };
  }

  factory Card.fromJson(Map<String, dynamic> json) {
    return Card(
      definition: json['definition'] as String,
      description: json['description'] as String,
    );
  }

  @override
  String toString(){
    return '{id: $id, setTitle: $setTitle, definition: $definition, description: $description, box: $box, lastTimeUsed: $lastTimeUsed}';
  }
}