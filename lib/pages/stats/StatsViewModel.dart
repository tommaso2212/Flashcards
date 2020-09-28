import 'package:Flashcards/data/model/TestCard.dart';
import 'package:Flashcards/pages/IViewModel.dart';
import 'package:Flashcards/data/model/Set.dart';
import 'package:Flashcards/utils/BoxUtils.dart';
import 'package:Flashcards/utils/style/ColorPalette.dart';

class StatsViewModel extends IViewModel {
  Map<Boxes, List<TestCard>> boxes;

  StatsViewModel(Set selectedSet) {
    init(selectedSet);
  }

  init(Set selectedSet) async {
    changeState(States.LOADING);
    boxes = {
      Boxes.Box1: [],
      Boxes.Box2: [],
      Boxes.Box3: [],
      Boxes.Box4: [],
      Boxes.Box5: [],
    };
    selectedSet.cards.forEach((element) {
      boxes[element.box].add(
        TestCard.fromCard(
          element,
          ColorPalette.fromHex(selectedSet.color),
        ),
      );
    });
    changeState(States.READY);
  }
}
