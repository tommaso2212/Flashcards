import 'package:Flashcards/data/dataaccess/SelectQuery.dart';
import 'package:Flashcards/data/model/TestCard.dart';
import 'package:Flashcards/pages/IViewModel.dart';
import 'package:Flashcards/data/model/Set.dart';
import 'package:Flashcards/utils/BoxUtils.dart';
import 'package:Flashcards/utils/style/ColorPalette.dart';

class HomePageViewModel extends IViewModel {
  List<TestCard> todaysCards;
  Map<Set, bool> sets;

  HomePageViewModel() {
    init();
  }

  void init() async {
    changeState(States.LOADING);
    //await DeleteQuery().delete();

    //await InsertQuery().insertFromJson(null, 'res/json/Fisica1.json');
    todaysCards = [];
    sets = {};
    var response = await SelectQuery().getFullSets();
    if (response == null) return;
    response.forEach((element) {
      sets.putIfAbsent(element, () => true);
    });
    setTodaysCard();
    changeState(States.READY);
  }

  void setTodaysCard() {
    todaysCards = [];
    sets.entries.forEach((mapElement) {
      if (mapElement.value) {
        mapElement.key.cards.forEach((element) {
          if (BoxUtils.isTodaysCard(element)) {
            todaysCards.add(
              TestCard.fromCard(
                element,
                ColorPalette.fromHex(mapElement.key.color),
              ),
            );
          }
        });
      }
    });
  }

  int todaysDone() {
    int length = 0;
    sets.entries.forEach((mapElement) {
      if (mapElement.value) {
        mapElement.key.cards.forEach((element) {
          if (element.lastTimeUsed.year == DateTime.now().year &&
              element.lastTimeUsed.month == DateTime.now().month &&
              element.lastTimeUsed.day == DateTime.now().day) length = length + 1;
        });
      }
    });
    return length;
  }

  void changeActiveSet(Set s) {
    sets[s] = !sets[s];
    print(sets[s]);
    setTodaysCard();
    notifyListeners();
  }
}
