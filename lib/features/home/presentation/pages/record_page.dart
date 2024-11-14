import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silvia_cpal_test/features/cpal/models/cpal_model.dart';
import 'package:silvia_cpal_test/shared/providers/record_provider.dart';
import 'package:silvia_cpal_test/themes/colors/color_theme.dart';
import 'package:silvia_cpal_test/themes/texts/text_style.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  String calculateAverage(List<double> numbers) {
    if (numbers.isEmpty) return "0.000";

    double sum = numbers.reduce((a, b) => a + b);
    double average = sum / numbers.length;

    return average.toStringAsFixed(3);
  }

  String calculateCorrectRate(int correctCount, int wrongCount) {
    int totalCount = correctCount + wrongCount;
    if (totalCount == 0) return "0.0";

    double correctRate = (correctCount / totalCount) * 100;
    return double.parse(correctRate.toStringAsFixed(2)).toString();
  }

  @override
  void initState() {
    context.read<RecordProvider>().loadCpalTestList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    RecordProvider recordProvider = context.watch<RecordProvider>();

    return ListView.separated(
      itemCount: recordProvider.recordList.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
      itemBuilder: (context, index) {
        final CpalTest item = recordProvider.recordList[index];

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: ColorTheme.of(context).background.normal.normal,
            ),
            child: Column(
              children: [
                Text(
                  datetimeToStringForYmd(item.testStartTime),
                  style: CustomTextStyle.of().subTitle,
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: item.recordList.length,
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 1,
                      color: ColorTheme.of(context).line.alternative,
                    );
                  },
                  itemBuilder: (context, index) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Lap ${index + 1}",
                          style: CustomTextStyle.of().body2,
                        ),
                        Text(
                          "${item.recordList[index].toString()}s",
                          style: CustomTextStyle.of().body2,
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 8),
                Divider(
                  thickness: 2,
                  color: ColorTheme.of(context).line.alternative,
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "기록 평균",
                      style: CustomTextStyle.of().body1,
                    ),
                    Text(
                      calculateAverage(item.recordList).toString(),
                      style: CustomTextStyle.of().body1,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "정답률",
                      style: CustomTextStyle.of().body1,
                    ),
                    Text(
                      "${calculateCorrectRate(item.correctCount, item.wrongCount)}%",
                      style: CustomTextStyle.of().body1,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String datetimeToStringForYmd(DateTime datetime) {
    return "${datetime.year}년 ${datetime.month}월 ${datetime.day}일 ${datetime.hour}시 ${datetime.minute}분";
  }
}
