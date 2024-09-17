import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Model/UiModel/board_model.dart';
import 'package:earn_streak/src/Repository/Services/Navigation/navigation_service.dart';
import 'package:earn_streak/src/Screens/MainScreen/BoardScreen/BalanceScreen/balance_screen.dart';
import 'package:earn_streak/src/Screens/MainScreen/BoardScreen/LeaderBoarderScreen/leader_board_screen.dart';
import 'package:earn_streak/src/Screens/MainScreen/BoardScreen/TransactionHistoryScreen/transaction_history_screen.dart';
import 'package:earn_streak/src/Utils/Helper/page_route.dart';
import 'package:flutter/material.dart';

class BoardNotifier extends ChangeNotifier{

  List<BoardModel> boardList = [
    BoardModel(title: BoardString.leaderBoard, image: AppImages.leaderBoardIcon),
    BoardModel(title: BoardString.balance, image: AppImages.walletIcon),
    BoardModel(title: BoardString.transactionHistory, image: AppImages.transactionHistoryIcon),
  ];

  onTap(context, index){
    if(index == 0){
     push(context, LeaderBoardScreen());
    }else if(index == 1){
      push(context, BalanceScreen());
    }else if(index == 2){
      push(context, TransactionHistoryScreen());
    }
  }

}