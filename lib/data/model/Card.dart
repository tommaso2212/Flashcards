class Card {
  final int id;
  final int setId;
  final String definition;
  final String description;
  final int box;

  Card({this.id, this.setId, this.definition, this.description, this.box = 1});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'setId': setId,
      'definition': definition,
      'description': description,
      'box': box
    };
  }
}