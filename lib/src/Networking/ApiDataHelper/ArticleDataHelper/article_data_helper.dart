import 'dart:developer';

import 'package:earn_streak/src/Constants/api_url.dart';
import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:earn_streak/src/Model/TransactionModel/transaction_model.dart';
import 'package:earn_streak/src/Model/UserCoinsDataModel/user_coins.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Networking/ApiService/api_service.dart';
import 'package:earn_streak/src/Screens/SplashScreen/splash_screen.dart';
import 'package:earn_streak/src/Utils/Notifier/setting_notifier.dart';
import 'package:earn_streak/src/Utils/app_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../Utils/Notifier/login_notifier.dart';

class ArticleHelper {
  Future<List<ArticleModel>> getArticle(context,
      {int page = 1,
        bool showLoader = false,
        List<String>? completeQuizs,
        List<String>? completeArticles,
        String? changedUrl}) async {
    // String postUrl = await sharedPref.read("postUrl");
    // String postUrl = Provider.of<SettingNotifier>(context, listen: false).commonModel.postBaseUrl ?? "";
    List<ArticleModel> tempArticleList = [];
    bool tempQuizSelect = false;
    String authToken = await sharedPref.read("authToken");
    final startTime = DateTime.now();
    try {
      // var res = await ApiService.request(context, "${AppUrls.getArticle}?per_page_data=${5}&page=$page", RequestMethods.GET, header: commonHeaderWithToken(authToken), showLoader: showLoader);
      var res = await ApiService.request(
          context, "$changedUrl/wp-json/earn/v1/posts?per_page_data=${10}&page=$page&filter_date=${loginResponseModel.userRegistered}", RequestMethods.GET,
          header: commonHeaderWithToken(authToken), showLoader: showLoader);
      if (res != null && res["success"] == true) {
        for (var element in res["data"]) {
          ArticleModel tempData = ArticleModel.fromJson(element ?? {});
          for (int i = 0; i < (completeQuizs?.length ?? 0); i++) {
            if (completeQuizs![i].toString().replaceAll(RegExp(r'[\[\]]'), '') == tempData.id.toString()) {
              tempQuizSelect = true;
              tempData = ArticleModel(
                  title: tempData.title,
                  url: tempData.url,
                  coin: tempData.coin,
                  slug: tempData.slug,
                  content: tempData.content,
                  id: tempData.id,
                  images: tempData.images,
                  isQuizComplete: true,
                  published: tempData.published,
                  quizs: tempData.quizs);
              // tempData.isQuizComplete = true;
            }
          }
          tempArticleList.add(tempData);
        }
      }
    } catch (e) {
      debugPrint("Get article throw exception $e");
    } finally {
      final endTime = DateTime.now();
      final duration = endTime.difference(startTime);
      print('API call took: ${duration.inMilliseconds} ms');
    }
    return tempArticleList;
  }

  updateUserCoin(context, coin, postId, title) async {
    String authToken = await sharedPref.read("authToken");
    bool isSuccess = false;
    try {
      var res = await ApiService.request(
        context,
        AppUrls.updateUserCoin,
        requestBody: {"user_id": loginResponseModel.id, "coin": coin, "post_id": postId, "title": title},
        RequestMethods.POST,
        header: commonHeaderWithToken(authToken),
      );
      if (res != null && res["success"] == true) {
        showSuccess(message: res["message"]);
        isSuccess = true;
      }
    } catch (e) {
      debugPrint("Get article throw exception $e");
    }
    return isSuccess;
  }

  // getTransactionData(context) async {
  //   final startTime = DateTime.now();
  //
  //   List<TransactionModel> tempTransactionList = [];
  //   String authToken = await sharedPref.read("authToken");
  //
  //   try {
  //     var res = await ApiService.request(
  //         context, "${AppUrls.getTransactionData}?user_id=${loginResponseModel.id}", RequestMethods.POST,
  //         header: commonHeaderWithToken(authToken));
  //
  //     if (res != null) {
  //       tempTransactionList = (res["data"] as List<dynamic>).map((element) => TransactionModel.fromJson(element ?? {})).toList();
  //     }
  //   } catch (e) {
  //     debugPrint("Get transaction threw exception $e");
  //   } finally {
  //     final endTime = DateTime.now();
  //     final duration = endTime.difference(startTime);
  //     print('API call took: ${duration.inMilliseconds} ms');
  //   }
  //   return tempTransactionList;
  // }

  getTransactionData(context, page, {bool? loader}) async {
    // Start time
    final startTime = DateTime.now();

    // TransactionModel transactionModel = TransactionModel();
    List<TransactionModel> tempTransactionList = [];
    String authToken = await sharedPref.read("authToken");
    try {
      var res = await ApiService.request(
          context,
          "${AppUrls.getTransactionData}?user_id=${loginResponseModel.id}&per_page_data=10&page=$page",
          RequestMethods.POST,
          header: commonHeaderWithToken(authToken),
          showLoader: loader ?? true);

      if (res != null) {
        for (var element in res["data"]) {
          TransactionModel transactionModel = TransactionModel.fromJson(element ?? {});
          tempTransactionList.add(transactionModel);
        }
      }
    } catch (e) {
      debugPrint("Get transaction throw exception $e");
    } finally {
      // End time
      final endTime = DateTime.now();

      // Calculate the difference
      final duration = endTime.difference(startTime);
      print('API call took: ${duration.inMilliseconds} ms');
    }
    return tempTransactionList;
  }

  readArticleAndUpdateTime(context, time, title, postId) async {
    Map<String, dynamic> body = {
      "user_id": loginResponseModel.id,
      "time": time,
      "title": title,
      "post_id": postId,
    };
    String authToken = await sharedPref.read("authToken");
    log("check update api body $body");
    try {
      var res = await ApiService.request(context, AppUrls.readArticleUpdateTime, RequestMethods.POST,
          header: commonHeaderWithToken(authToken), requestBody: body, showLoader: false);
      if (res != null) {
        debugPrint("Print update time successfully");
      }
    } catch (e) {
      debugPrint("Read article time update throw exception $e");
    }
  }

  quizAndReadArticleComplete(context, String postId, {bool? isReadArticle, String? title}) async {
    String authToken = await sharedPref.read("authToken");
    Map<String, dynamic> body = {"user_id": loginResponseModel.id, "post_id": postId, "is_read": 1, "title": title};
    try {
      var res = await ApiService.request(
          context, isReadArticle ?? false ? AppUrls.articleReadComplete : AppUrls.playQuizComplete, RequestMethods.POST,
          header: commonHeaderWithToken(authToken), requestBody: body, showLoader: false);
      if (res != null) {
        debugPrint("Print read article complete successfully");
      }
    } catch (e) {
      debugPrint("quiz read complete throw exception $e");
    }
  }

  Future<List<String>> getReadArticleAndPlayQuiz(context, String type) async {
    List<String> tempQuizAndArticleList = [];
    String authToken = await sharedPref.read("authToken");
    Map<String, dynamic> body = {
      "user_id": loginResponseModel.id,
      // "type" : type
    };
    try {
      var res = await ApiService.request(context, AppUrls.completedQuizAndArticle, RequestMethods.POST,
          header: commonHeaderWithToken(authToken), requestBody: body, showLoader: false);
      if (res != null && res["success"] == true) {
        print("res completed article nd post is ${res["data"]}");
        // for(var element in res["data"]){
        tempQuizAndArticleList.add(res['data'].toString());
        /*if(type == "post"){
             completeArticles.add(res['data'].toString());
           }else{
             completeQuizs.add(res['data'].toString());
           }*/
        // }
      }
    } catch (e) {
      debugPrint("Get complete quiz and article throw exception $e");
    }
    return tempQuizAndArticleList;
  }

  /// Calling api get user coins data
  getUserCon(context) async {
    UserCoins? userCoins;
    String authToken = await sharedPref.read("authToken");
    try {
      var res = await ApiService.request(context, AppUrls.getUsersCoin, RequestMethods.POST,
          requestBody: {
            "user_id": loginResponseModel.id,
          },
          header: commonHeaderWithToken(authToken),
          showLoader: false);
      if (res != null) {
        userCoins = UserCoins.fromJson(res['data']);
        debugPrint("res coins data is${res['data']}");
      }
    } catch (e) {
      debugPrint("Get Coins   throw exception $e");
    }
    return userCoins;
  }
}
