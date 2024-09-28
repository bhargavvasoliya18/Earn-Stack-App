import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/ArticleDataHelper/article_data_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeNotifier extends ChangeNotifier {
  List<ArticleModel> articleList = [];

  getArticleApiCall(context) async {
    articleList = await ArticleHelper().getArticle(context);
    print("Article list length ${articleList.length}");
    notifyListeners();
  }

  iniState(context) {
    getArticleApiCall(context);
  }

  DateTime? timeLaunched;
  DateTime? timeResumed;
  Duration? timeSpent;

  Future<void> launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      timeLaunched = DateTime.now();
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }
}
