import 'package:earn_streak/src/Constants/api_url.dart';
import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/ArticleDataHelper/article_data_helper.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/AuthDataHelper/auth_data_helper.dart';
import 'package:earn_streak/src/Networking/ApiService/api_service.dart';
import 'package:earn_streak/src/Utils/Notifier/login_notifier.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {

  List<String> completeQuizs = [];
  List<String> completeArticles = [];
  List<ArticleModel> articleList = [];
  bool isLoadMore = false;
  bool isHaseMoreData = true;
  int page = 1;
  bool isLoaderShow = true;

  String? selectArticleId;

  getArticleApiCall(context, {bool showLoader = false}) async {
    print("check get article api call");
    isLoaderShow = true;
    notifyListeners();
    List<ArticleModel> articleLists = await ArticleHelper().getArticle(context, page: page, showLoader: false, completeArticles: completeArticles, completeQuizs: completeQuizs);
    isHaseMoreData = articleLists.isNotEmpty;
    articleList.addAll(articleLists);
    isLoaderShow = false;
    notifyListeners();
  }

  readArticleAndUpdate(context)async{
    await ArticleHelper().quizAndReadArticleComplete(context, selectArticleId ?? "", isReadArticle: true);
  }

  completeQuizAndArticle(context)async{
    await getReadArticleAndPlayQuiz(context);

   // List<String> getQuizAndArticle = await ArticleHelper().getReadArticleAndPlayQuiz(context);
   //  if(type == "post"){
   //    completeArticles.addAll(getQuizAndArticle);
   //    notifyListeners();
   //  }else{
   //    completeQuizs.addAll(getQuizAndArticle);
   //    notifyListeners();
   //  }
  }

  Future<List<String>>getReadArticleAndPlayQuiz(context)async{
    print("getReadArticleAndPlayQuiz navigator back");
    completeArticles.clear();
    completeQuizs.clear();
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
        for(var element in res["data"]["post"]){
          completeArticles.add(element);
          notifyListeners();
        }
        for(var element in res["data"]["quiz"]){
          completeQuizs.add(element);
          notifyListeners();
        }
        print("check article list length ${completeArticles.length}");
      }
    }
    catch(e){
      print("Get complete quiz and article throw exception $e");
    }
    return tempQuizAndArticleList;
  }

  iniState(context) {
    page = 1;
    notifyListeners();
    completeQuizAndArticle(context);
    Future.delayed(Duration(milliseconds: 2000),(){
      getArticleApiCall(context, showLoader: true);
    });
    notifyListeners();
  }

  onScroll(BuildContext context) async {
    if (!isLoadMore) {
      isLoadMore = true;
      notifyListeners();
      if (isHaseMoreData) {
        page++;
        await getArticleApiCall(context, showLoader: false);
      }
      isLoadMore = false;
      await Future.delayed(const Duration(milliseconds: 800));
      notifyListeners();
    }
  }

  readArticleTimeApiCall(context, time)async{
    await ArticleHelper().readArticleAndUpdateTime(context, time);
  }

}
