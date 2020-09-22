import 'package:Flashcards/data/dataaccess/DataAccess.dart';
import 'package:Flashcards/data/model/Card.dart';
import 'package:Flashcards/data/model/Set.dart';
import 'package:sqflite/sqflite.dart';

class InsertQuery extends DataAccess {

  Future<void> insertSet(Set newSet) async {
    await getDatabase().then(
      (value) => value.insert(
        'sets',
        newSet.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    );
  }

  Future<void> insertCard(Card newCard) async {
    await getDatabase().then(
      (value) => value.insert(
        'cards',
        newCard.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      ),
    );
  }
}
