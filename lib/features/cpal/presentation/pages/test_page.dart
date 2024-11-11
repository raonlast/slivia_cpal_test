import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:silvia_cpal_test/features/cpal/presentation/widgets/image_card_widget.dart';
import 'package:silvia_cpal_test/features/cpal/presentation/widgets/progress_bar_widget.dart';
import 'package:silvia_cpal_test/features/cpal/providers/cpal_provider.dart';
import 'package:silvia_cpal_test/shared/providers/record_provider.dart';
import 'package:silvia_cpal_test/shared/widgets/primary_button.dart';
import 'package:silvia_cpal_test/themes/colors/color_theme.dart';

class TestPage extends StatelessWidget {
  static Route<void> route() {
    return MaterialPageRoute(
      builder: (_) => ChangeNotifierProvider(
        create: (_) => CpalProvider(),
        child: const TestPage(),
      ),
    );
  }

  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    CpalProvider cpalProvider = context.watch<CpalProvider>();
    RecordProvider recordProvider = context.read<RecordProvider>();

    if (cpalProvider.isDone) {
      recordProvider.saveRecord(
        recordList: cpalProvider.recordTimeList,
        wrongCount: cpalProvider.wrongCount,
        correctCount: cpalProvider.correctCount,
      );
    }

    return Scaffold(
      backgroundColor: ColorTheme.of(context).background.normal.alternative,
      appBar: AppBar(
        backgroundColor: ColorTheme.of(context).background.normal.alternative,
      ),
      body: SafeArea(
        child: Column(
          children: [
            cpalProvider.isShowAnswer
                ? const CustomProgressBar()
                : const SizedBox(
                    height: 4,
                  ),
            const Expanded(child: SizedBox()),
            Center(
              child: SizedBox(
                height: 400,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(3, (rowIndex) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: List.generate(2, (colIndex) {
                              int imageIndex = rowIndex * 2 + colIndex;
                              String imageAssetUrl =
                                  cpalProvider.imageList[imageIndex];

                              return ImageCard(
                                imageAssetUrl: imageAssetUrl,
                              );
                            }),
                          );
                        }),
                      ),
                    ),
                    if (cpalProvider.answerImage.isNotEmpty)
                      Center(
                        child: ImageCard(
                          isAnswerCard: true,
                          imageAssetUrl: cpalProvider.answerImage,
                        ),
                      ),
                  ],
                ),
              ),
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child: PrimaryButton(
                text: "START",
                disable: cpalProvider.isStarted,
                onTap: () {
                  context.read<CpalProvider>().onStart();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
