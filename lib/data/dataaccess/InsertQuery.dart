import 'dart:convert';
import 'dart:io';
import 'package:Flashcards/data/dataaccess/DataAccess.dart';
import 'package:Flashcards/data/dataaccess/SelectQuery.dart';
import 'package:Flashcards/data/model/Card.dart';
import 'package:Flashcards/data/model/Set.dart';
import 'package:Flashcards/utils/BoxUtils.dart';
import 'package:http/http.dart';
import 'package:permission_handler/permission_handler.dart';
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

  Future<bool> insertFromJson(String url, String path) async {
    try {
      String source;
      if (path == null) {
        var downloadJson = await Client().get(url);
        if (downloadJson.statusCode != 200) return false;
        source = downloadJson.body;
      } else {
        //source = await rootBundle.loadString(path);
        var status = await Permission.storage.status;
        if (!status.isGranted) {
          await Permission.storage.request();
        }
        source = await File(path).readAsString();
      }
      Set parsedSet = Set.fromJson(json.decode(source));
      await insertSet(parsedSet);
      List<Card> containedCards = await SelectQuery().getCardsBySet(parsedSet.title);
      for (Card card in parsedSet.cards) {
        if (containedCards.firstWhere((element) => element.definition == card.definition, orElse: () => null) == null) {
          await insertCard(
            Card(
              setTitle: parsedSet.title,
              definition: card.definition,
              description: card.description,
              box: Boxes.Box1,
              lastTimeUsed: DateTime.now().subtract(
                Duration(days: 1),
              ),
            ),
          );
        }
      }
      return true;
    } catch (identifier) {
      return false;
    }
  }
}
