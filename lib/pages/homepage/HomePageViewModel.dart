import 'package:Flashcards/data/dataaccess/InsertQuery.dart';
import 'package:Flashcards/data/dataaccess/SelectQuery.dart';
import 'package:Flashcards/data/model/Card.dart';
import 'package:Flashcards/pages/IViewModel.dart';
import 'package:Flashcards/data/model/Set.dart';
import 'package:Flashcards/utils/BoxUtils.dart';

class HomePageViewModel extends IViewModel {
  List<Set> sets;
  List<Card> todaysCards;

  HomePageViewModel() {
    init();
  }

  init() async {
    changeState(States.LOADING);
    await InsertQuery().insertFromJson(null, 'res/json/Fisica1.json');
    await SelectQuery().getFullSets().then((value) {
      sets = value;
      todaysCards = _getTodaysCards();
      changeState(States.READY);
    });
  }

  List<Card> _getTodaysCards(){
    List<Card> todaysCards = [];
    sets.forEach((element) {
      element.cards.forEach((element) {
        if(BoxUtils.isTodaysCard(element)) todaysCards.add(element);
      });
    });
    return todaysCards;
  }
}
