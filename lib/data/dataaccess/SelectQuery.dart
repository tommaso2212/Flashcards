import 'package:Flashcards/data/dataaccess/DataAccess.dart';
import 'package:Flashcards/data/model/Card.dart';
import 'package:Flashcards/data/model/Set.dart';

class SelectQuery extends DataAccess {
  Future<List<Set>> getSets() async {
    var database = await getDatabase();
    List<Map<String, dynamic>> map = await database.query('sets');
    return List.generate(
      map.length,
      (index) => Set(
        id: map[index]['id'],
        title: map[index]['title'],
        color: map[index]['color'],
      ),
    );
  }

  Future<List<Card>> getCardsBySet(int setId) async {
    var database = await getDatabase();
    List<Map<String, dynamic>> map = await database.query(
      'cards',
      where: "setId = ?",
      whereArgs: [setId],
    );
    return List.generate(
      map.length,
      (index) => Card(
        id: map[index]['id'],
        setId: map[index]['setId'],
        definition: map[index]['definition'],
        description: map[index]['description'],
        box: map[index]['box'],
      ),
    );
  }

  Future<List<Set>> getFullSets() async {
    List<Set> sets = await getSets();
    sets.forEach((element) async {
      element.cards = await getCardsBySet(element.id);
    });
    return sets;
  }
}
