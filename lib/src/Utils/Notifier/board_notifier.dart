import 'package:earn_streak/src/Constants/app_images.dart';
import 'package:earn_streak/src/Constants/app_strings.dart';
import 'package:earn_streak/src/Model/UiModel/board_model.dart';
import 'package:flutter/material.dart';

class BoardNotifier extends ChangeNotifier{

  List<BoardModel> boardList = [
    BoardModel(title: BoardString.leaderBoard, image: AppImages.leaderBoardIcon),
    BoardModel(title: BoardString.balance, image: AppImages.walletIcon),
    BoardModel(title: BoardString.transactionHistory, image: AppImages.transactionHistoryIcon),
  ];

}