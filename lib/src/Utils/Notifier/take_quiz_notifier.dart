import 'package:earn_streak/src/Model/UiModel/quiz_model.dart';
import 'package:flutter/material.dart';

class TakeQuizNotifier extends ChangeNotifier {
  double progress = 0.1;

  int selectIndex = 0;

  List<QuizModel> quizList = [
    QuizModel(
      question: "Which calendar is the most widespread calendar used today?",
      answer: ["TEST 1", "TEST 2", "TEST 3", "TEST 4"],
    ),
    QuizModel(
      question: "Which calendar is the most widespread calendar used today?",
      answer: ["TEST 11", "TEST 22", "TEST 33", "TEST 44"],
    ),
    QuizModel(
      question: "Which calendar is the most widespread calendar used today?",
      answer: ["TEST 111", "TEST 222", "TEST 333", "TEST 444"],
    ),
    QuizModel(
      question: "Which calendar is the most widespread calendar used today?",
      answer: ["TEST 1111", "TEST 2222", "TEST 3333", "TEST 4444"],
    ),
    QuizModel(
      question: "Which calendar is the most widespread calendar used today?",
      answer: ["TEST 11111", "TEST 22222", "TEST 3333", "TEST 44444"],
    ),
    QuizModel(
      question: "Which calendar is the most widespread calendar used today?",
      answer: ["TEST 12", "TEST 23", "TEST 34", "TEST 45"],
    ),
    QuizModel(
      question: "Which calendar is the most widespread calendar used today?",
      answer: ["TEST 81", "TEST 82", "TEST 83", "TEST 84"],
    ),
    QuizModel(
      question: "Which calendar is the most widespread calendar used today?",
      answer: ["TEST 91", "TEST 92", "TEST 93", "TEST 94"],
    ),
    QuizModel(
      question: "Which calendar is the most widespread calendar used today?",
      answer: ["TEST 01", "TEST 02", "TEST 03", "TEST 04"],
    ),
    QuizModel(
      question: "Which calendar is the most widespread calendar used today?",
      answer: ["TEST 1", "TEST 2", "TEST 3", "TEST 4"],
    ),
    QuizModel(
      question: "Which calendar is the most widespread calendar used today?",
      answer: ["TEST 1", "TEST 2", "TEST 3", "TEST 4"],
    ),
  ];

  backQuestion() {
    selectIndex--;
    notifyListeners();
  }

  nextQuestion() {
    progress + 0.1;
    selectIndex++;
    notifyListeners();
  }
}
