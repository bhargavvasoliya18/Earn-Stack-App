import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:flutter/material.dart';

class TakeQuizNotifier extends ChangeNotifier {

  ArticleModel articleModel = ArticleModel();
  double progress = 0.1;

  int selectIndex = 0;
  int lastIndex = 0;
  int? selectQuizIndex;

  List<int> userSelectAnswer = [];

  backQuestion() {
    selectIndex--;
    notifyListeners();
  }

  nextQuestion() {
    progress + 0.1;
    selectIndex++;
    notifyListeners();
  }

  selectQuiz(index){
    selectQuizIndex = index;
    userSelectAnswer.add(selectQuizIndex!);
    notifyListeners();
  }

  initState(ArticleModel articleModel){
    selectIndex = 0;
    this.articleModel = articleModel;
    print("last index $lastIndex");
    notifyListeners();
  }

}
