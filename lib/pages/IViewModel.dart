import 'package:flutter/widgets.dart';

class IViewModel extends ChangeNotifier{
  States currentState;

  void changeState(States state){
    currentState = state;
    notifyListeners();
  }
}

enum States {
  LOADING,
  READY,
  FAILED,
}