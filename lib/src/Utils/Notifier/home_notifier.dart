import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/ArticleDataHelper/article_data_helper.dart';
import 'package:flutter/material.dart';

class HomeNotifier extends ChangeNotifier{

  List<ArticleModel> articleList = [];

   getArticleApiCall(context)async{
   articleList = await ArticleHelper().getArticle(context);
   print("Article list length ${articleList.length}");
   notifyListeners();
   }

   iniState(context){
     getArticleApiCall(context);
   }

}