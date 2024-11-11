import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class CpalProvider extends ChangeNotifier {
  List<String> imageList = [
    "assets/icons/Avocado.svg",
    "assets/icons/Carrot.svg",
    "assets/icons/Peach.svg",
    "assets/icons/Eggplant.svg",
    "assets/icons/Pear.svg",
    "assets/icons/Orange.svg",
  ];
  int showAnswerSecond = 2;

  List<String> _selectableImageList = [];
  List<String> get selectableImageList => _selectableImageList;

  final List<String> _errorImageList = [];
  List<String> get errorImageList => _errorImageList;

  bool _isStarted = false;
  bool get isStarted => _isStarted;

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

  void onCorrect() {
    DateTime now = DateTime.now();

    double elapsedTime = now.difference(_recordStartTime).inMilliseconds / 1000;
    _recordTimeList.add(elapsedTime);

    _selectableImageList.remove(_answerImage);
  }

  final RiveAnimationController controller = SimpleAnimation(
    'show',
    autoplay: false,
  );

  void playAnimation() {
    controller.isActive = true;
    notifyListeners();
  }

  void stopAnimation() {
    controller.isActive = false;
    notifyListeners();
  }
}

// List<String> totalImageList = [
//   "assets/icons/Avocado.svg",
//   "assets/icons/Carrot.svg",
//   "assets/icons/Coconut_cut.svg",
//   "assets/icons/Eggplant.svg",
//   "assets/icons/Lemon.svg",
//   "assets/icons/Orange.svg",
//   "assets/icons/Peach.svg",
//   "assets/icons/Pear.svg",
//   "assets/icons/Pepper.svg",
//   "assets/icons/Pomegranate.svg",
//   "assets/icons/Potato.svg",
//   "assets/icons/Red_Apple.svg",
//   "assets/icons/Red_onion.svg",
//   "assets/icons/Tomato.svg",
//   "assets/icons/Corn.svg",
//   "assets/icons/Cucumber.svg",
// ];
