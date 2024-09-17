import 'package:flutter/material.dart';

class LeaderBoardNotifier extends ChangeNotifier{

  int selectIndex = 0;

  selectTabIndex(index){
    selectIndex = index;
    notifyListeners();
  }

}