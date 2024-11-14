import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:silvia_cpal_test/features/cpal/constants/cpal_constant.dart';
import 'package:silvia_cpal_test/features/cpal/models/cpal_model.dart';

class CpalProvider extends ChangeNotifier {
  List<String> _selectableImageList = [];
  List<String> get selectableImageList => _selectableImageList;

  late CpalTest _cpalTest;
  CpalTest get cpalTest => _cpalTest;

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
  }

  void onStart() {
    _cpalTest = CpalTest(
      testStartTime: DateTime.now(),
      recordList: [],
      correctCount: 0,
      wrongCount: 0,
    );

    _selectableImageList = List.from(CpalConstant.imageList);
    _isStarted = true;
    _isShowAnswer = true;
    _isDone = false;
    notifyListeners();

    Future.delayed(const Duration(seconds: CpalConstant.cardRevealTime), () {
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
    _cpalTest = _cpalTest.copyWith(wrongCount: _cpalTest.wrongCount + 1);
  }

  void onCorrect() {
    DateTime now = DateTime.now();

    double elapsedTime =
        now.difference(_cpalTest.testStartTime).inMilliseconds / 1000;
    _cpalTest.recordList.add(elapsedTime);

    _selectableImageList.remove(_answerImage);
    _cpalTest = _cpalTest.copyWith(correctCount: _cpalTest.correctCount + 1);
  }

  bool canFlip() {
    return _isFlipedCard || _isShowAnswer || !_isStarted;
  }
}
