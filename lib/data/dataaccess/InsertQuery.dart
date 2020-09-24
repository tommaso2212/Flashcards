import 'dart:convert';
import 'package:Flashcards/data/dataaccess/DataAccess.dart';
import 'package:Flashcards/data/dataaccess/SelectQuery.dart';
import 'package:Flashcards/data/model/Card.dart';
import 'package:Flashcards/data/model/Set.dart';
import 'package:Flashcards/utils/BoxUtils.dart';
import 'package:http/http.dart';
import 'package:flutter/services.dart' show rootBundle;
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

  Future<void> insertFromJson(String url, String path) async {
    String source;
    if (path == null) {
      var downloadJson = await Client().get(url);
      if (downloadJson.statusCode != 200) return;
      source = downloadJson.body;
    } else {
      source = await rootBundle.loadString(path);
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
            lastTimeUsed: DateTime.now(),
          ),
        );
      }
    }
  }
}
