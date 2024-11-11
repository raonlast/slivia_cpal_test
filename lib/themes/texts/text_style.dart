import 'package:flutter/material.dart';
import 'package:silvia_cpal_test/themes/colors/color_palette.dart';

class CustomTextStyle {
  final FontWeight? fontWeight;
  Color? fontColor;

  CustomTextStyle.of({this.fontWeight = FontWeight.w600, this.fontColor});

  // labelNetural
  Color defaultTextColor =
      ColorPalette.coolNeutral22.withOpacity(ColorPalette.opacity88);

  TextStyleScheme get style => sympleTextStyle;

  TextStyle get heading =>
      style.heading.copyWith(color: fontColor ?? defaultTextColor);
  TextStyle get title =>
      style.title.copyWith(color: fontColor ?? defaultTextColor);
  TextStyle get subTitle =>
      style.subTitle.copyWith(color: fontColor ?? defaultTextColor);

  /// fontWeight : Semibold
  TextStyle get body1 =>
      style.body1.copyWith(color: fontColor ?? defaultTextColor);

  /// fontWeight : Regular
  TextStyle get body2 =>
      style.body2.copyWith(color: fontColor ?? defaultTextColor);
  TextStyle get caption =>
      style.caption.copyWith(color: fontColor ?? defaultTextColor);
  TextStyle get undertext =>
      style.undertext.copyWith(color: fontColor ?? defaultTextColor);
}

class TextStyleScheme {
  TextStyle heading;
  TextStyle title;
  TextStyle subTitle;
  TextStyle body1;
  TextStyle body2;
  TextStyle caption;
  TextStyle undertext;

  TextStyleScheme({
    required this.heading,
    required this.title,
    required this.subTitle,
    required this.body1,
    required this.body2,
    required this.caption,
    required this.undertext,
  });
}

final TextStyleScheme sympleTextStyle = TextStyleScheme(
  heading: const TextStyle(
    fontSize: 26.0,
    fontWeight: FontWeight.w600,
    height: 34 / 26,
    letterSpacing: -3 / 26,
  ),
  title: const TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w600,
    height: 28 / 20,
    letterSpacing: -3 / 20,
  ),
  subTitle: const TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w600,
    height: 26 / 18,
    letterSpacing: -2 / 18,
  ),
  body1: const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w600,
    height: 24 / 16,
    letterSpacing: -2 / 16,
  ),
  body2: const TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w400,
    height: 24 / 16,
    letterSpacing: -2 / 16,
  ),
  caption: const TextStyle(
    fontSize: 13.0,
    fontWeight: FontWeight.w500,
    height: 20 / 13,
    letterSpacing: -2 / 13,
  ),
  undertext: const TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.w600,
    height: 16 / 11,
    letterSpacing: -2 / 11,
  ),
);
