import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class CpalProvider extends ChangeNotifier {
  List<String> imageList = [
    "assets/icons/Avocado.svg",
    "assets/icons/Carrot.svg",
    "assets/icons/Peach.svg",
    "assets/icons/Eggplant.svg",
    "assets/icons/Pear.svg",
    "assets/icons/Orange.svg",
  ];
  int showAnswerSecond = 5;

  List<String> _selectableImageList = [];
  List<String> get selectableImageList => _selectableImageList;

  int _wrongCount = 0;
  int get wrongCount => _wrongCount;

  int _correctCount = 0;
  int get correctCount => _correctCount;

  bool _isStarted = false;
  bool get isStarted => _isStarted;

  bool _isFlipedCard = false;
  bool get isFlipedCard => _isFlipedCard;

  bool _isFlipedWrongCard = false;
  bool get isFlipedWrongCard => _isFlipedWrongCard;

  bool _isShowAnswer = false;
  bool get isShowAnswer => _isShowAnswer;

  String _answerImage = "";
  String get answerImage => _answerImage;

  bool _isDone = false;
  bool get isDone => _isDone;

  final List<double> _recordTimeList = [];
  List<double> get recordTimeList => _recordTimeList;

  DateTime _recordStartTime = DateTime.now();

  void getAnswerImage() {
    if (_selectableImageList.isEmpty) {
      _answerImage = "";
      _isStarted = false;
      _isDone = true;
      notifyListeners();
      return;
    }

    Random random = Random();
    int answerIndex = random.nextInt(_selectableImageList.length);

    _answerImage = _selectableImageList[answerIndex];
    notifyListeners();

    _recordStartTime = DateTime.now();
  }

  void onStart() {
    _selectableImageList = List.from(imageList);
    _recordTimeList.clear();
    _isStarted = true;
    _isShowAnswer = true;
    _isDone = false;
    notifyListeners();

    Future.delayed(Duration(seconds: showAnswerSecond), () {
      _isShowAnswer = false;
      notifyListeners();

      Future.delayed(const Duration(seconds: 1), () {
        getAnswerImage();
      });
    });
  }

  void onFlipCard(bool isFlip) {
    _isFlipedCard = isFlip;
  }

  void onWrong() {
    _isFlipedWrongCard = true;
    _wrongCount++;
  }

  void onCorrect() {
    DateTime now = DateTime.now();

    double elapsedTime = now.difference(_recordStartTime).inMilliseconds / 1000;
    _recordTimeList.add(elapsedTime);

    _selectableImageList.remove(_answerImage);
    _correctCount++;
  }
}
