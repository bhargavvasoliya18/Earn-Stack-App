import 'package:earn_streak/src/Constants/app_date_formats.dart';
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

  convertDateFormat(String dateString){

    // Parse the string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Format the DateTime object into the desired format
    String formattedDate = outputFormat.format(dateTime);
    print(formattedDate); // Output: 03/10/2024
    return formattedDate;
  }

}