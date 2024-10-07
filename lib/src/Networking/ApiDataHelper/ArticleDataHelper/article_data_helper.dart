import 'package:earn_streak/src/Constants/api_url.dart';
import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:earn_streak/src/Model/TransactionModel/transaction_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Networking/ApiService/api_service.dart';
import 'package:earn_streak/src/Utils/app_utils.dart';

import '../../../Utils/Notifier/login_notifier.dart';

class ArticleHelper {

  // List<String> completeQuizs = [];
  // List<String> completeArticles = [];

  Future<List<ArticleModel>> getArticle(context, {int page = 1,bool showLoader = false, List<String>? completeQuizs, List<String>? completeArticles}) async {
    List<ArticleModel> tempArticleList = [];
    bool tempQuizSelect = false;
    String authToken = await sharedPref.read("authToken");
    try {
      var res = await ApiService.request(context, "${AppUrls.getArticle}?per_page_data=${10}&page=$page", RequestMethods.GET, header: commonHeaderWithToken(authToken),showLoader: showLoader);
      if (res != null && res["success"] == true) {
        for (var element in res["data"]) {
          ArticleModel tempData = ArticleModel.fromJson(element ?? {});
          for (int i = 0; i < (completeQuizs?.length ?? 0); i++) {
              if(completeQuizs![i].toString().replaceAll(RegExp(r'[\[\]]'), '') == tempData.id.toString()){
                tempQuizSelect = true;
                tempData = ArticleModel(
                  title: tempData.title, url: tempData.url, coin: tempData.coin,
                  slug: tempData.slug, content: tempData.content, id: tempData.id, images: tempData.images, isQuizComplete: true,
                  published: tempData.published, quizs: tempData.quizs
                );
              // tempData.isQuizComplete = true;
            }
          }

          for (int i = 0; i < (completeArticles?.length ?? 0); i++) {
            if(completeArticles![i].toString().replaceAll(RegExp(r'[\[\]]'), '') == tempData.id.toString() ){
              tempData = ArticleModel(
                  title: tempData.title, url: tempData.url, coin: tempData.coin,
                  slug: tempData.slug, content: tempData.content, id: tempData.id, images: tempData.images, isArticleComplete: true, isQuizComplete: tempQuizSelect,
                  published: tempData.published, quizs: tempData.quizs
              );
              // tempData.isArticleComplete = true;
            }
          }
          Future.delayed(Duration(milliseconds: 1000));
          tempArticleList.add(tempData);
        }
      }
    } catch (e) {
      print("Get article throw exception $e");
    }
    return tempArticleList;
  }

  updateUserCoin(context, coin) async {
    String authToken = await sharedPref.read("authToken");
    bool isSuccess = false;
    try {
      var res = await ApiService.request(
        context,
        AppUrls.updateUserCoin,
        requestBody: {
          "user_id": loginResponseModel.id,
          "coin": coin,
        },
        RequestMethods.POST,
        header: commonHeaderWithToken(authToken),
      );
      if (res != null && res["success"] == true) {
        showSuccess(message: res["message"]);
        isSuccess = true;
      }
    } catch (e) {
      print("Get article throw exception $e");
    }
    return isSuccess;
  }

  getTransactionData(context)async{
    // TransactionModel transactionModel = TransactionModel();
    List<TransactionModel> tempTransactionList = [];
    String authToken = await sharedPref.read("authToken");
    try{
      var res = await ApiService.request(context, "${AppUrls.getTransactionData}?user_id=${loginResponseModel.id}", RequestMethods.POST, header: commonHeaderWithToken(authToken));
      if(res != null){
        for(var element in res["data"]){
          TransactionModel transactionModel = TransactionModel.fromJson(element ?? {});
          tempTransactionList.add(transactionModel);
        }
        // transactionModel = TransactionModel.fromJson(res["data"] ?? {});
      }
    }
      catch(e){
        print("Get transaction throw exception $e");
      }
      return tempTransactionList;
  }

  readArticleAndUpdateTime(context, time)async{
    Map<String, dynamic> body = {
      "user_id" : loginResponseModel.id,
      "time": time
    };
    String authToken = await sharedPref.read("authToken");
    try{
      var res = await ApiService.request(context, AppUrls.readArticleUpdateTime, RequestMethods.POST, header: commonHeaderWithToken(authToken), requestBody: body, showLoader: false);
      if(res != null){
        print("Print update time successfully");
      }
    }
     catch(e){
        print("Read article time update throw exception $e");
     }
  }

  quizAndReadArticleComplete(context, String postId, {bool? isReadArticle})async{
    String authToken = await sharedPref.read("authToken");
    Map<String, dynamic> body = {
      "user_id" : loginResponseModel.id,
      "post_id" : postId,
      "is_read" : 1
    };
    try{
      var res = await ApiService.request(context, isReadArticle ?? false? AppUrls.articleReadComplete : AppUrls.playQuizComplete, RequestMethods.POST, header: commonHeaderWithToken(authToken), requestBody: body, showLoader: false);
      if(res != null){
        print("Print read article complete successfully");
      }
    }
      catch(e){
         print("quiz read complete throw exception $e");
      }
  }

  Future<List<String>>getReadArticleAndPlayQuiz(context, String type)async{
    List<String> tempQuizAndArticleList = [];
    String authToken = await sharedPref.read("authToken");
    Map<String, dynamic> body = {
       "user_id": loginResponseModel.id,
      // "type" : type
    };
    try{
      var res = await ApiService.request(context, AppUrls.completedQuizAndArticle, RequestMethods.POST, header: commonHeaderWithToken(authToken), requestBody: body, showLoader: false);
      if(res != null && res["success"] == true){
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
    }
     catch(e){
        print("Get complete quiz and article throw exception $e");
     }
     return tempQuizAndArticleList;
  }

}
