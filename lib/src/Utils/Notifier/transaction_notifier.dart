import 'package:earn_streak/src/Model/TransactionModel/transaction_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/ArticleDataHelper/article_data_helper.dart';
import 'package:flutter/material.dart';

class TransactionNotifier extends ChangeNotifier{

  TransactionModel transactionModel = TransactionModel();

  List<String> transactionHistoryList = [
    "Sign up bonus",
    "Invite reward",
    "Redeem bonus",
    "Article read point",
    "Quiz point"
  ];

  getTransactionApiCall(context)async{
    transactionModel = await ArticleHelper().getTransactionData(context);
    notifyListeners();
  }

  getTransactionAmount(index){
    Map<String, dynamic> transactionMap = {
      "Sign up bonus": transactionModel.signUp,
      "Invite reward": transactionModel.invite,
      "Redeem bonus": transactionModel.invite,
      "Article read point": transactionModel.article,
      "Quiz point": transactionModel.quiz,
    };

    return transactionMap[transactionHistoryList[index]] ?? "0";
  }

}