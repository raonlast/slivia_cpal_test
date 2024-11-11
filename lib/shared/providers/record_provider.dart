import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RecordProvider with ChangeNotifier {
  List<Map<DateTime, List<double>>> _recordList = [];
  List<Map<DateTime, List<double>>> get recordList => _recordList;

  void saveRecord(List<double> recordList) async {
    DateTime now = DateTime.now();
    _recordList.add({now: recordList});

    final prefs = await SharedPreferences.getInstance();

    List<Map<String, List<double>>> jsonCompatibleList =
        _recordList.map((dateMap) {
      return dateMap
          .map((key, value) => MapEntry(key.toIso8601String(), value));
    }).toList();

    String jsonString = jsonEncode(jsonCompatibleList);
    await prefs.setString('record_list', jsonString);
  }

  Future<List<Map<DateTime, List<double>>>> loadRecordList() async {
    final prefs = await SharedPreferences.getInstance();

    String? jsonString = prefs.getString('record_list');
    if (jsonString == null) return [];

    List<dynamic> jsonDecoded = jsonDecode(jsonString);

    List<Map<DateTime, List<double>>> recordList = jsonDecoded.map((map) {
      Map<String, List<double>> stringMap = Map<String, List<double>>.from(map);
      return stringMap
          .map((key, value) => MapEntry(DateTime.parse(key), value));
    }).toList();

    return recordList;
  }
}
