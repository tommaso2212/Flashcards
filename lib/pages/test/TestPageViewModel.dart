import 'package:Flashcards/data/dataaccess/UpdateQuery.dart';
import 'package:Flashcards/data/model/Card.dart';
import 'package:Flashcards/pages/IViewModel.dart';
import 'package:Flashcards/utils/BoxUtils.dart';

class TestPageViewModel extends IViewModel{

  int currentIndex;
  bool isSideA;
  int correctCount;

  TestPageViewModel(){
    currentIndex = 0;
    correctCount = 0;
    isSideA = true;
  }

  void changeSide(){
    isSideA = !isSideA;
    notifyListeners();
  }

  void _updateBox(Card card) async {
    await UpdateQuery().updateCard(card);
    nextCard();
  }

  void nextCard(){
    currentIndex = currentIndex + 1;
    notifyListeners();
  }

  void previousCard(){
    currentIndex = currentIndex - 1;
    notifyListeners();
  }

  void correctAnswer(Card card){
    correctCount = correctCount + 1;
    if(card.box != Boxes.Box5){
      card.box = Boxes.values[card.box.index + 1];
    }
    card.lastTimeUsed = DateTime.now();
    _updateBox(card);
  }

  void wrongAnswer(Card card){
    card.box = Boxes.Box1;
    _updateBox(card);
  }
}