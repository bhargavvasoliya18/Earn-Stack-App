import 'dart:convert';

import 'package:earn_streak/src/Constants/app_date_formats.dart';
import 'package:earn_streak/src/Model/TransactionModel/transaction_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/ArticleDataHelper/article_data_helper.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../Constants/api_url.dart';
import '../../Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import '../../Networking/ApiService/api_service.dart';
import 'login_notifier.dart';
import 'package:http/http.dart' as http;

class TransactionNotifier extends ChangeNotifier {
  TransactionModel transactionModel = TransactionModel();

  // List<dynamic> transactionHistoryList = [];
  List<TransactionModel> transactionHistoryList = [];
  bool isTransactionHistoryApiCall = false;

  getTransactionApiCall(context) async {
    transactionHistoryList = await ArticleHelper().getTransactionData(context, 1);
    notifyListeners();
  }

  /*getTransactionData(context) async {
    final startTime = DateTime.now();

    String authToken = await sharedPref.read("authToken");

    try {
      var res = await ApiService.request(
          context, "${AppUrls.getTransactionData}?user_id=${loginResponseModel.id}", RequestMethods.POST,
          header: commonHeaderWithToken(authToken));

      if (res != null) {
        // tempTransactionList = (res["data"] as List<dynamic>).map((element) => TransactionModel.fromJson(element ?? {})).toList();
        transactionHistoryList = (res["data"] as List<dynamic>).map((element) => TransactionModel.fromJson(element ?? {})).toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Get transaction threw exception $e");
    } finally {
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);
      print('API call took: ${duration.inMilliseconds} ms');
    }
    // return tempTransactionList;
  }*/

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
    String formattedDate = outputFormat.format(dateTime);
    print(formattedDate); // Output: 03/10/2024
    return formattedDate;
  }

  bool loading = true;
  String? error;
  double? loadTime;
  bool refreshing = false;

  Future<void> onRefresh(context) async {
    refreshing = true; // Start refreshing
    notifyListeners();
    await await ArticleHelper().getTransactionData(context, 1); // Fetch new data
  }
}
