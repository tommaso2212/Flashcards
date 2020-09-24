import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DataAccess {

  Future<Database> getDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'flashcard_database.db'),
      onCreate: (db, _) async {
        await db.execute('CREATE TABLE sets(title TEXT PRIMARY KEY NOT NULL, color TEXT)');
        await db.execute(
            'CREATE TABLE cards(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, setTitle TEXT, definition TEXT, description TEXT, box INTEGER, lastTimeUsed TEXT, FOREIGN KEY(setTitle) REFERENCES sets(title) ON DELETE CASCADE)');
        print('Database succesfully created');
      },
      version: 1,
    );
  }

  Future<void> delete() async {
    await deleteDatabase(
      join(await getDatabasesPath(), 'flashcard_database.db'),
    );
    print('Database succesfully deleted');
  }
}
