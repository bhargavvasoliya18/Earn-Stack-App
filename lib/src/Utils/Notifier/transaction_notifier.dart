import 'package:earn_streak/src/Constants/app_date_formats.dart';
import 'package:earn_streak/src/Model/TransactionModel/transaction_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/ArticleDataHelper/article_data_helper.dart';
import 'package:flutter/material.dart';

class TransactionNotifier extends ChangeNotifier {
  TransactionModel transactionModel = TransactionModel();

  List<TransactionModel> transactionHistoryList = [];
  // bool isTransactionHistoryApiCall = false;

  getTransactionApiCall(context) async {
    transactionHistoryList = await ArticleHelper().getTransactionData(context, 1);
    notifyListeners();
  }

  bool isLoadMore = false;
  bool isHaseMoreData = true;
  int page = 1;

  onScroll(BuildContext context) async {
    if (!isLoadMore) {
      isLoadMore = true;
      notifyListeners();
      if (isHaseMoreData) {
        page++;

        List<TransactionModel> tmpTransactionHistoryList = await ArticleHelper().getTransactionData(context, page, loader: false);
        transactionHistoryList.addAll(tmpTransactionHistoryList);
        notifyListeners();
        isHaseMoreData = tmpTransactionHistoryList.isNotEmpty;
        notifyListeners();
        debugPrint("Scroll call ${transactionHistoryList.length} $isHaseMoreData");
      }
      isLoadMore = false;
      await Future.delayed(const Duration(milliseconds: 800));
      notifyListeners();
    }
  }

  convertDateFormat(String dateString) {
    // Parse the string into a DateTime object
    DateTime dateTime = DateTime.parse(dateString);

    // Format the DateTime object into the desired format
    String formattedDate = outputMonthFormat.format(dateTime);
    print(formattedDate); // Output: 03/10/2024
    return formattedDate;
  }

  bool loading = true;
  String? error;
  double? loadTime;
  bool refreshing = false;

  Future<void> onRefresh(context) async {
    page = 1;
    isHaseMoreData = true;
    refreshing = true; // Start refreshing
    transactionHistoryList.clear();
    notifyListeners();
    transactionHistoryList = await ArticleHelper().getTransactionData(context, 1); // Fetch new data
    notifyListeners();
  }
}
