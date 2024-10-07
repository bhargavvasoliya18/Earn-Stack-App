import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/ArticleDataHelper/article_data_helper.dart';
import 'package:earn_streak/src/Utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../Screens/MainScreen/HomeScreen/TakeQuizeScreen/Module/conrats_dialog.dart';

class TakeQuizNotifier extends ChangeNotifier {

  ArticleModel articleModel = ArticleModel();
  int totalQuestions = 0;
  double singleProgressCount = 0.0;

  int selectIndex = 0;
  int lastIndex = 0;
  int? selectQuizAnswerIndex;

  int rightAnswer = 0;
  int wrongAnswer = 0;

  List<String> selectAnswerList = [];
  List<int> userSelectAnswer = [];

  backQuestion() {
    selectIndex--;
    notifyListeners();
  }

  double get progress {
    return (selectIndex + 1) / totalQuestions;
  }

  nextQuestion() {
    selectIndex++;
    notifyListeners();
  }

  selectQuiz(index) {
    selectQuizAnswerIndex = index;
    userSelectAnswer.add(selectQuizAnswerIndex!);
    notifyListeners();
  }

  quizResult(context) async {
    rightAnswer = 0;
    wrongAnswer = 0;
    for (int i = 0; i < articleModel.quizs!.length; i++) {
      if ((int.parse(articleModel.quizs![i].answer!) - 1).toString() == selectAnswerList[i]) {
        rightAnswer++;
      } else {
        wrongAnswer++;
      }
    }

   String winingCoins = ((double.parse(articleModel.coin.toString()) / articleModel.quizs!.length) * double.parse(rightAnswer.toString())).toStringAsFixed(2);

    bool isUpdate = await ArticleHelper().updateUserCoin(context, winingCoins);
    playCompleteQuiz(context);
    debugPrint('RESULT $isUpdate');
    if (isUpdate == true) {
      congratsDialog(context, rightAnswer.toString(), wrongAnswer.toString(), articleModel.quizs!.length.toString());
    } else {
      showError(message: "Coin not update");
    }
  }

  playCompleteQuiz(context)async{
    await ArticleHelper().quizAndReadArticleComplete(context, articleModel.id.toString(), isReadArticle: false);
  }

  initState(ArticleModel articleModel) {
    selectIndex = 0;
    singleProgressCount = 100 / articleModel.quizs!.length;
    totalQuestions = articleModel.quizs!.length;

    this.articleModel = articleModel;
    selectAnswerList.clear();
    for (int i = 0; i < articleModel.quizs!.length; i++) {
      articleModel.quizs![i].selectAnswer = "";
      debugPrint("OP1");
      selectAnswerList.add("");
    }
    debugPrint("last index $lastIndex");
    notifyListeners();
  }

}
