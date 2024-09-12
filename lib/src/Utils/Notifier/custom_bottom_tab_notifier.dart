import 'package:earn_streak/src/Utils/Notifier/base_notifier.dart';
import 'package:flutter/material.dart';

int selectedBottomTab = 0;
int prevBottomTab = 0;
PageController bottomTabController = PageController(initialPage: selectedBottomTab,keepPage: false);

class CustomBottomTabNotifier extends BaseNotifier{

  void initState(){
    bottomTabController.addListener(() {
      notifyListeners();
    });
    print("bottom tab controller status custom bottom tab notifier init is ${bottomTabController.hasClients}");
    notifyListeners();
  }

  onIconTap(context, int index)async{
    selectedBottomTab = index;
    bottomTabController.jumpToPage(index);
    notifyListeners();
  }

  @override
  void onDispose() {
    // TODO: implement onDispose
  }
}