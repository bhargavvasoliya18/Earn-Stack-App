import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/ArticleDataHelper/article_data_helper.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeNotifier extends ChangeNotifier {
  List<ArticleModel> articleList = [];
  bool isLoadMore = false;
  bool isHaseMoreData = true;
  int page = 1;

  getArticleApiCall(context, {bool showLoader = false}) async {
    List<ArticleModel> articleLists = await ArticleHelper().getArticle(context, page: page, showLoader: showLoader);
    print("Article list length ${articleList.length}");
    isHaseMoreData = articleLists.isNotEmpty;
    articleList.addAll(articleLists);
    notifyListeners();
  }

  iniState(context) {
    getArticleApiCall(context, showLoader: true);
    notifyListeners();
  }

  DateTime? timeLaunched;
  DateTime? timeResumed;
  Duration? timeSpent;

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
