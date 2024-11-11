import 'dart:convert';

class CpalTest {
  final DateTime testTime;
  final List<double> recordList;
  final int correctCount;
  final int wrongCount;

  CpalTest({
    required this.testTime,
    required this.recordList,
    required this.correctCount,
    required this.wrongCount,
  });

  Map<String, dynamic> toMap() {
    return {
      'testTime': testTime.toIso8601String(),
      'recordList': jsonEncode(recordList),
      'correctCount': correctCount,
      'wrongCount': wrongCount,
    };
  }

  factory CpalTest.fromMap(Map<String, dynamic> map) {
    return CpalTest(
      testTime: DateTime.parse(map['testTime']),
      recordList: List<double>.from(jsonDecode(map['recordList'])),
      correctCount: map['correctCount'],
      wrongCount: map['wrongCount'],
    );
  }
}
