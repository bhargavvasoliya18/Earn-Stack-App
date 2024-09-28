import 'package:earn_streak/src/Model/ArticleModel/article_model.dart';
import 'package:earn_streak/src/Networking/ApiDataHelper/ArticleDataHelper/article_data_helper.dart';
import 'package:earn_streak/src/Utils/app_utils.dart';
import 'package:flutter/material.dart';

import '../../Screens/MainScreen/HomeScreen/TakeQuizeScreen/Module/conrats_dialog.dart';

class TakeQuizNotifier extends ChangeNotifier {
  ArticleModel articleModel = ArticleModel();
  double progress = 0.1;

  int selectIndex = 0;
  int lastIndex = 0;
  int? selectQuizAnswerIndex;

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
    bool isUpdate = await ArticleHelper().updateUserCoin(context, rightAnswer.toString());
    debugPrint('RESULT $isUpdate');

    if (isUpdate == true) {
      congratsDialog(context, rightAnswer.toString(), wrongAnswer.toString(), articleModel.quizs!.length.toString());
    } else {
      showError(message: "Coin not update");
    }
  }

  initState(ArticleModel articleModel) {
    selectIndex = 0;
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

  List<String> selectAnswerList = [];
  int rightAnswer = 0;
  int wrongAnswer = 0;
}
