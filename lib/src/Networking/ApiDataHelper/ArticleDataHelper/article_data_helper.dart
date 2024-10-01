import 'package:earn_streak/src/Constants/api_url.dart';
import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:earn_streak/src/Model/TransactionModel/transaction_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Networking/ApiService/api_service.dart';
import 'package:earn_streak/src/Utils/app_utils.dart';

import '../../../Utils/Notifier/login_notifier.dart';

class ArticleHelper {

  Future<List<ArticleModel>> getArticle(context, {int page = 1,bool showLoader = false}) async {
    List<ArticleModel> tempArticleList = [];
    String authToken = await sharedPref.read("authToken");
    try {
      var res =
          await ApiService.request(context, "${AppUrls.getArticle}?per_page_data=${10}&page=$page", RequestMethods.GET, header: commonHeaderWithToken(authToken),showLoader: showLoader);
      if (res != null && res["success"] == true) {
        for (var element in res["data"]) {
          ArticleModel tempData = ArticleModel.fromJson(element ?? {});
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
    TransactionModel transactionModel = TransactionModel();
    String authToken = await sharedPref.read("authToken");
    try{
      var res = await ApiService.request(context, "${AppUrls.getTransactionData}?user_id=${loginResponseModel.id}", RequestMethods.POST, header: commonHeaderWithToken(authToken));
      if(res != null){
        transactionModel = TransactionModel.fromJson(res["data"] ?? {});
      }
    }
      catch(e){
        print("Get transaction throw exception $e");
      }
      return transactionModel;
  }

}
