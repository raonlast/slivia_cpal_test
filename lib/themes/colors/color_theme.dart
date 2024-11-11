import 'package:flutter/material.dart';
import 'package:silvia_cpal_test/themes/colors/color_scheme.dart';
import 'package:silvia_cpal_test/themes/colors/dark_color_theme.dart';
import 'package:silvia_cpal_test/themes/colors/light_color_theme.dart';

class ColorTheme {
  final BuildContext context;
  final Brightness? forceBrightness;

  ColorTheme.of(this.context, {this.forceBrightness});

  Brightness get brightness => forceBrightness ?? Theme.of(context).brightness;

  CustomColorScheme get theme =>
      brightness == Brightness.light ? lightTheme : darkTheme;

  PrimaryColor get primary => PrimaryColor(theme);
  LabelColor get label => LabelColor(theme);
  BackgroundColor get background => BackgroundColor(theme);
  InteractionColor get interaction => InteractionColor(theme);
  LineColor get line => LineColor(theme);
  StatusColor get status => StatusColor(theme);
  AccentColor get accent => AccentColor(theme);
  InverseColor get inverse => InverseColor(theme);
  StaticColor get static => StaticColor(theme);
  FillColor get fill => FillColor(theme);
}

class PrimaryColor {
  final CustomColorScheme theme;

  PrimaryColor(this.theme);

  Color get normal => theme.primaryNormal;
  Color get strong => theme.primaryStrong;
  Color get heavy => theme.primaryHeavy;
}

class LabelColor {
  final CustomColorScheme theme;

  LabelColor(this.theme);

  Color get normal => theme.labelNormal;
  Color get strong => theme.labelStrong;
  Color get neutral => theme.labelNeutral;
  Color get alternative => theme.labelAlternative;
  Color get assistive => theme.labelAssistive;
  Color get disable => theme.labelDisable;
}

class BackgroundColor {
  final CustomColorScheme theme;

  BackgroundColor(this.theme);

  BackgroundNormalColor get normal => BackgroundNormalColor(theme);
  BackgroundElevatedColor get elevated => BackgroundElevatedColor(theme);
}

class BackgroundNormalColor {
  final CustomColorScheme theme;

  BackgroundNormalColor(this.theme);

  Color get normal => theme.backgroundNormalNormal;
  Color get alternative => theme.backgroundNormalAlternative;
}

class BackgroundElevatedColor {
  final CustomColorScheme theme;

  BackgroundElevatedColor(this.theme);

  Color get normal => theme.backgroundElevatedNormal;
  Color get alternative => theme.backgroundElevatedAlternative;
}

class InteractionColor {
  final CustomColorScheme theme;

  InteractionColor(this.theme);

  Color get inactive => theme.interactionInactive;
  Color get disable => theme.interactionDisable;
}

class LineColor {
  final CustomColorScheme theme;

  LineColor(this.theme);

  Color get normal => theme.lineNormal;
  Color get neutral => theme.lineNeutral;
  Color get alternative => theme.lineAlternative;
}

class StatusColor {
  final CustomColorScheme theme;

  StatusColor(this.theme);

  Color get positive => theme.statusPositive;
  Color get caoutionary => theme.statusCautionary;
  Color get destructive => theme.statusDestructive;
}

class AccentColor {
  final CustomColorScheme theme;

  AccentColor(this.theme);

  Color get redOrange => theme.accentRedorange;
  Color get lime => theme.accentLime;
  Color get cyan => theme.accentCyan;
  Color get lightBlue => theme.accentLightblue;
  Color get blue => theme.accentBlue;
  Color get pink => theme.accentPink;
  Color get violet => theme.accentViolet;
}

class InverseColor {
  final CustomColorScheme theme;

  InverseColor(this.theme);

  Color get primary => theme.inversePrimary;
  Color get background => theme.inverseBackground;
  Color get label => theme.inverseLabel;
}

class StaticColor {
  final CustomColorScheme theme;

  StaticColor(this.theme);

  Color get white => theme.staticWhite;
  Color get black => theme.staticBlack;
}

class FillColor {
  final CustomColorScheme theme;

  FillColor(this.theme);

  Color get normal => theme.fillNormal;
  Color get strong => theme.fillStrong;
  Color get alternative => theme.fillAlternative;
}
