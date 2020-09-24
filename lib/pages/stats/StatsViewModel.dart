import 'package:Flashcards/pages/IViewModel.dart';
import 'package:Flashcards/data/model/Set.dart';
import 'package:Flashcards/utils/BoxUtils.dart';

class StatsViewModel extends IViewModel{

  Map<Boxes, int> boxes;

  StatsViewModel(Set selectedSet){
    init(selectedSet);
  }

  init(Set selectedSet) async {
    changeState(States.LOADING);
    boxes = {
      Boxes.Box1:0,
      Boxes.Box2:0,
      Boxes.Box3:0,
      Boxes.Box4:0,
      Boxes.Box5:0,
    };
    selectedSet.cards.forEach((element) {
      boxes[element.box] = boxes[element.box] +1;
    });
    changeState(States.READY);
  }
}