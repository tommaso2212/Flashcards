import 'package:Flashcards/data/dataaccess/DataAccess.dart';

class DeleteQuery extends DataAccess {
  Future<void> deleteSet(int id) async {
    await getDatabase().then(
      (value) => value.delete(
        'sets',
        where: "id = ?",
        whereArgs: [id],
      ),
    );
  }
}
