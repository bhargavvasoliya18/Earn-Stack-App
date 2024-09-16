import 'package:earn_streak/src/Model/UiModel/quiz_model.dart';
import 'package:flutter/material.dart';

class TakeQuizNotifier extends ChangeNotifier{

  double progress = 0.8;

  List<QuizModel> quizList = [
    QuizModel(question: "Which calendar is the most widespread calendar used today?", ),
    QuizModel(),
    QuizModel(),
    QuizModel(),
    QuizModel(),
    QuizModel(),
    QuizModel(),
    QuizModel(),
    QuizModel(),
    QuizModel(),
    QuizModel(),
  ];

}