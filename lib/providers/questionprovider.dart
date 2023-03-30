import 'package:flutter/material.dart';

class QuestionProvider extends ChangeNotifier {
  static QuestionProvider? _instance;
  static QuestionProvider getInstance() {
    if (_instance == null) {
      _instance = QuestionProvider();
      return _instance!;
    } else {
      return _instance!;
    }
  }

  final _questionsList = [
    'Is he/she interested in football?',
    'Does he/she enjoy cooking?',
    'Does he/she enjoy playing board games?',
    'Does he/she often use different tech gadgets?',
    'Does he/she often listen to music?',
    'Does he/she enjoy reading?',
  ];
  int _questionNum = 0;
  String get question => _questionsList[_questionNum];
  int get questionNum => _questionNum;
  void moveToNextQuestion() {
    if (_questionNum < _questionsList.length - 1) {
      _questionNum++;
    } else {
      _questionNum = 0;
    }
    notifyListeners();
    //log('Notified QuestionStatus');
  }
}
