import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:silvia_cpal_test/features/cpal/models/cpal_model.dart';

class RecordProvider with ChangeNotifier {
  final List<CpalTest> _recordList = [];
  List<CpalTest> get recordList => _recordList;

  void saveRecord({required CpalTest cpalTest}) async {
    DateTime now = DateTime.now();
    _recordList.add(
      CpalTest(
        testStartTime: now,
        recordList: cpalTest.recordList,
        correctCount: cpalTest.correctCount,
        wrongCount: cpalTest.wrongCount,
      ),
    );

    final prefs = await SharedPreferences.getInstance();

    final List<String> testListString =
        _recordList.map((test) => jsonEncode(test.toMap())).toList();
    await prefs.setStringList('cpalTestList', testListString);
  }

  void loadCpalTestList() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? testListString = prefs.getStringList('cpalTestList');

    if (testListString == null) return;

    List<CpalTest> loadRecordList = testListString
        .map((value) => CpalTest.fromMap(jsonDecode(value)))
        .toList();

    _recordList.clear();
    _recordList.addAll(loadRecordList);

    notifyListeners();
  }
}
