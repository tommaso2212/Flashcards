import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class DataAccess {
  Future<Database> getDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), 'flashcard_database.db'),
      onCreate: (db, version) async {
        await db.execute('CREATE TABLE sets(id INTEGER AUTO_INCREMENT PRIMARY KEY, title TEXT, color TEXT)');
        await db.execute(
            'CREATE TABLE cards(id INTEGER AUTO_INCREMENT PRIMARY KEY, setId INTEGER, definition TEXT, description TEXT, box INTEGER, FOREIGN KEY(setId) REFERENCES sets(id) ON DELETE CASCADE)');
      },
      version: 1,
    );
  }
}
