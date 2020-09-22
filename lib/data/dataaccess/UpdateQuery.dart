import 'package:Flashcards/data/dataaccess/DataAccess.dart';
import 'package:Flashcards/data/model/Card.dart';

class UpdateQuery extends DataAccess {
  Future<void> updateCard(Card card) async {
    await getDatabase().then(
      (value) => value.update(
        'cards',
        card.toMap(),
        where: "id = ?",
        whereArgs: [card.id],
      ),
    );
  }
}
