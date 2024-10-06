import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/ArticleDataHelper/article_data_helper.dart';
import 'package:earn_streak/src/Networking/FirebaseNotificationHelper/firebase_notification.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier {

  List<String> completeQuizs = [];
  List<String> completeArticles = [];
  List<ArticleModel> articleList = [];
  bool isLoadMore = false;
  bool isHaseMoreData = true;
  int page = 1;

  String? selectArticleId;

  getArticleApiCall(context, {bool showLoader = false}) async {
    List<ArticleModel> articleLists = await ArticleHelper().getArticle(context, page: page, showLoader: showLoader, completeArticles: completeArticles, completeQuizs: completeQuizs);
    isHaseMoreData = articleLists.isNotEmpty;
    articleList.addAll(articleLists);
    notifyListeners();
  }

  readArticleAndUpdate(context)async{
    await ArticleHelper().quizAndReadArticleComplete(context, selectArticleId ?? "", isReadArticle: true);
  }

  completeQuizAndArticle(context, String type)async{
   List<String> getQuizAndArticle = await ArticleHelper().getReadArticleAndPlayQuiz(context, type);
    if(type == "post"){
      completeArticles.addAll(getQuizAndArticle);
      notifyListeners();
    }else{
      completeQuizs.addAll(getQuizAndArticle);
      notifyListeners();
    }
  }

  iniState(context) {
    FirebaseMessagesHelper.initFirebaseMessage(context);
    completeQuizAndArticle(context, "post");
    completeQuizAndArticle(context, "quiz");
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
