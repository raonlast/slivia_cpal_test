import 'dart:convert';

class CpalTest {
  final DateTime testStartTime;
  final List<double> recordList;
  final int correctCount;
  final int wrongCount;

  CpalTest({
    required this.testStartTime,
    required this.recordList,
    required this.correctCount,
    required this.wrongCount,
  });

  CpalTest copyWith({
    DateTime? testStartTime,
    List<double>? recordList,
    int? correctCount,
    int? wrongCount,
  }) {
    return CpalTest(
      testStartTime: testStartTime ?? this.testStartTime,
      recordList: recordList ?? this.recordList,
      correctCount: correctCount ?? this.correctCount,
      wrongCount: wrongCount ?? this.wrongCount,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'testStartTime': testStartTime.toIso8601String(),
      'recordList': jsonEncode(recordList),
      'correctCount': correctCount,
      'wrongCount': wrongCount,
    };
  }

  factory CpalTest.fromMap(Map<String, dynamic> map) {
    return CpalTest(
      testStartTime: DateTime.parse(map['testStartTime']),
      recordList: List<double>.from(jsonDecode(map['recordList'])),
      correctCount: map['correctCount'],
      wrongCount: map['wrongCount'],
    );
  }
}
