import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silvia_cpal_test/shared/providers/record_provider.dart';
import 'package:silvia_cpal_test/themes/colors/color_theme.dart';
import 'package:silvia_cpal_test/themes/texts/text_style.dart';

class RecordPage extends StatefulWidget {
  const RecordPage({super.key});

  @override
  State<RecordPage> createState() => _RecordPageState();
}

class _RecordPageState extends State<RecordPage> {
  @override
  Widget build(BuildContext context) {
    RecordProvider recordProvider = context.read<RecordProvider>();

    return ListView.separated(
      itemCount: recordProvider.recordList.length,
      separatorBuilder: (context, index) {
        return const SizedBox(height: 16);
      },
      itemBuilder: (context, index) {
        final Map<DateTime, List<double>> item =
            recordProvider.recordList[index];

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
                  datetimeToStringForYmd(item.keys.first),
                  style: CustomTextStyle.of().subTitle,
                ),
                const SizedBox(height: 16),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: item.values.first.length,
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
                          "${item.values.first[index].toString()}s",
                          style: CustomTextStyle.of().body2,
                        ),
                      ],
                    );
                  },
                ),
                // ...item.values.first.map((times) {
                //   return Row(
                //     children: [],
                //   );
                // })
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
