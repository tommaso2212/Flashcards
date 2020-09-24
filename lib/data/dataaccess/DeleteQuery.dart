import 'package:Flashcards/data/dataaccess/DataAccess.dart';

class DeleteQuery extends DataAccess {
  Future<void> deleteSet(String title) async {
    await getDatabase().then(
      (value) => value.delete(
        'sets',
        where: "title = ?",
        whereArgs: [title],
      ),
    );
  }
}
