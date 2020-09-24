import 'package:Flashcards/data/dataaccess/DataAccess.dart';
import 'package:Flashcards/data/model/Card.dart';
import 'package:Flashcards/data/model/Set.dart';
import 'package:Flashcards/utils/BoxUtils.dart';

class SelectQuery extends DataAccess {
  Future<List<Set>> getSets() async {
    var database = await getDatabase();
    List<Map<String, dynamic>> map = await database.query('sets');
    return List.generate(
      map.length,
      (index) => Set(
        title: map[index]['title'],
        color: map[index]['color'],
        cards: [],
      ),
    );
  }

  Future<List<Card>> getCards() async {
    var database = await getDatabase();
    List<Map<String, dynamic>> map = await database.query('cards');
    return List.generate(
      map.length,
      (index) => Card(
        id: map[index]['id'] as int,
        setTitle: map[index]['setTitle'],
        definition: map[index]['definition'],
        description: map[index]['description'],
        box: Boxes.values[map[index]['box'] as int],
        lastTimeUsed: DateTime.parse(map[index]['lastTimeUsed']),
      ),
    );
  }

  Future<List<Card>> getCardsBySet(String setTitle) async {
    var database = await getDatabase();
    List<Map<String, dynamic>> map = await database.query(
      'cards',
      where: "setTitle=?",
      whereArgs: [setTitle],
    );
    return List.generate(
      map.length,
      (index) => Card(
        id: map[index]['id'] as int,
        setTitle: map[index]['setTitle'],
        definition: map[index]['definition'],
        description: map[index]['description'],
        box: Boxes.values[map[index]['box'] as int],
        lastTimeUsed: DateTime.parse(map[index]['lastTimeUsed']),
      ),
    );
  }

  Future<List<Set>> getFullSets() async {
    List<Set> sets = await getSets();
    for (Set set in sets){
      set.cards = await getCardsBySet(set.title);
    }
    return sets;
  }
}
