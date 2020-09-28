import 'package:Flashcards/data/dataaccess/DataAccess.dart';

class DeleteQuery extends DataAccess {
  Future<void> deleteSet(String title) async {
    var db = await getDatabase();
    await db.delete(
      'cards',
      where: "setTitle = ?",
      whereArgs: [title],
    );
    await db.delete(
      'sets',
      where: "title = ?",
      whereArgs: [title],
    );
  }
}
