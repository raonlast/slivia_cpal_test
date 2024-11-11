import 'package:flutter/material.dart';
import 'package:silvia_cpal_test/features/cpal/presentation/pages/test_page.dart';
import 'package:silvia_cpal_test/shared/widgets/primary_button.dart';

class TestChoosePage extends StatelessWidget {
  const TestChoosePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          PrimaryButton(
            text: "CPAL 검사 시작하기",
            onTap: () {
              Navigator.push(context, TestPage.route());
            },
          ),
        ],
      ),
    );
  }
}
