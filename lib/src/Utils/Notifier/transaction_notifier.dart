import 'package:earn_streak/src/Model/TransactionModel/transaction_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/ArticleDataHelper/article_data_helper.dart';
import 'package:flutter/material.dart';

class TransactionNotifier extends ChangeNotifier{

  TransactionModel transactionModel = TransactionModel();

  List<TransactionModel> transactionHistoryList = [];

  getTransactionApiCall(context)async{
    transactionHistoryList = await ArticleHelper().getTransactionData(context);
    notifyListeners();
  }

}