import 'dart:math';

import 'package:flutter/material.dart';
import 'package:silvia_cpal_test/features/cpal/constants/cpal_constant.dart';
import 'package:silvia_cpal_test/features/cpal/models/cpal_model.dart';

class CpalTestProvider extends ChangeNotifier {
  late AnimationController _controller;
  late Animation<double> _flipAnimation;
  bool isFlipped = false;

  Animation<double> get flipAnimation => _flipAnimation;

  CpalTestProvider(TickerProvider vsync) {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: vsync,
    );
    _flipAnimation = Tween<double>(begin: 0, end: 3.14).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  List<String> _selectableImageList = [];

  late CpalTest _cpalTest;
  CpalTest get cpalTest => _cpalTest;

  bool _isStarted = false;
  bool get isStarted => _isStarted;

  bool _isShowAllCard = false;
  bool get isShowAllCard => _isShowAllCard;

  String? _answerImage;
  String? get answerImage => _answerImage;

  final List<double> _recordTimeList = [];
  List<double> get recordTimeList => _recordTimeList;

  void onStart() {
    _isStarted = true;
    _isShowAllCard = true;
    _selectableImageList = List.from(CpalConstant.imageList);
    notifyListeners();

    Future.delayed(const Duration(seconds: CpalConstant.cardRevealTime), () {
      _isShowAllCard = false;
      notifyListeners();

      Future.delayed(const Duration(seconds: 1), () {});
    });
  }

  void getAnswerImage() {
    if (_selectableImageList.isEmpty) {
      _answerImage = null;
      _isStarted = false;
      return notifyListeners();
    }

    Random random = Random();
    int answerIndex = random.nextInt(_selectableImageList.length);

    _answerImage = _selectableImageList[answerIndex];
    notifyListeners();
  }

  void onTapCard() {}
}
