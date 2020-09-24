import 'package:Flashcards/data/model/Card.dart';

class BoxUtils {

  static Map<Boxes, int> boxDuration = {
    Boxes.Box1:1,
    Boxes.Box2:2,
    Boxes.Box3:4,
    Boxes.Box4:7,
    Boxes.Box5:10,
  };

  static Map<Boxes, String> boxTitle = {
    Boxes.Box1:'Box 1 - Every day',
    Boxes.Box2:'Box 2 - Every ${boxDuration[Boxes.Box2]} days',
    Boxes.Box3:'Box 3 - Every ${boxDuration[Boxes.Box3]} days',
    Boxes.Box4:'Box 4 - Every ${boxDuration[Boxes.Box4]} days',
    Boxes.Box5:'Box 5 - Every ${boxDuration[Boxes.Box5]} days',
  };

  static bool isTodaysCard(Card card){
    if(card.box == Boxes.Box1) return true;
    DateTime date = DateTime.now().subtract(Duration(days: boxDuration[card.box]));
    if(date.day == card.lastTimeUsed.day && date.month == card.lastTimeUsed.month && date.year == card.lastTimeUsed.year) return true;
    return false;
  }
}

enum Boxes {
  None,
  Box1,
  Box2,
  Box3,
  Box4,
  Box5
}