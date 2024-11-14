import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:silvia_cpal_test/features/cpal/providers/cpal_test_provider.dart';
import 'package:silvia_cpal_test/themes/colors/color_theme.dart';

class CardWidget extends StatelessWidget {
  final String cardImage;

  const CardWidget({
    super.key,
    required this.cardImage,
  });

  @override
  Widget build(BuildContext context) {
    final cpalProvider = Provider.of<CpalTestProvider>(context);

    return GestureDetector(
      onTap: () {
        cpalProvider.onTapCard();
      },
      child: AnimatedBuilder(
        animation: cpalProvider.flipAnimation,
        builder: (context, child) {
          return Transform(
            transform: Matrix4.rotationY(cpalProvider.flipAnimation.value),
            alignment: Alignment.center,
            child: Container(
              decoration: BoxDecoration(
                color: cpalProvider.isShowAllCard
                    ? ColorTheme.of(context).background.normal.normal
                    : null,
                borderRadius: BorderRadius.circular(4),
                // border: widget.isAnswerCard || _isAnswer || _isWrong
                //     ? Border.all(
                //         color: _isWrong
                //             ? ColorTheme.of(context).status.destructive
                //             : ColorTheme.of(context)
                //                 .primary
                //                 .normal
                //                 .withOpacity(0.7),
                //       )
                //     : null,
                boxShadow: [
                  BoxShadow(
                    color: ColorTheme.of(context).static.black.withOpacity(0.1),
                    offset: const Offset(0, 4),
                    blurRadius: 16,
                  ),
                ],
              ),
              // cpalProvider.flipAnimation.value > 1.57 || widget.isAnswerCard
              child: cpalProvider.flipAnimation.value > 1.57
                  ? Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/Card_front.svg',
                          width: 80,
                          height: 100,
                        ),
                        Transform.flip(
                          flipX: true,
                          child: SvgPicture.asset(
                            cardImage,
                            width: 68,
                            height: 68,
                          ),
                        )
                      ],
                    )
                  : SvgPicture.asset(
                      'assets/icons/Card_back.svg',
                      width: 80,
                      height: 100,
                    ),
            ),
          );
        },
      ),
    );
  }
}
