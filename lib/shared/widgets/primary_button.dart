import 'package:flutter/material.dart';
import 'package:silvia_cpal_test/themes/colors/color_theme.dart';
import 'package:silvia_cpal_test/themes/texts/text_style.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function() onTap;
  final Color? backgroundColor;
  final Color? textColor;
  final bool disable;

  const PrimaryButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
    this.textColor,
    this.disable = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disable ? null : onTap,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: backgroundColor ??
              (disable
                  ? ColorTheme.of(context).interaction.disable
                  : ColorTheme.of(context).primary.normal),
        ),
        child: Text(
          text,
          style: CustomTextStyle.of(
            fontColor: textColor ??
                (disable
                    ? ColorTheme.of(context).label.assistive
                    : ColorTheme.of(context).static.white),
          ).subTitle,
        ),
      ),
    );
  }
}
