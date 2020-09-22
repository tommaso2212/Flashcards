import 'package:Flashcards/utils/ColorPalette.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class CustomTextStyle {
  final double defaultArea = 313600;
  static double pixelScale;

  CustomTextStyle(Window window) {
    double width = window.physicalSize.width / window.devicePixelRatio;
    double height = window.physicalSize.height / window.devicePixelRatio;
    double x = width * height / defaultArea;
    if (x < 0.5) pixelScale = -2;
    if (x >= 0.5 && x < 0.75) pixelScale = -1;
    if (x >= 0.75 && x < 1.25) pixelScale = 0;
    if (x >= 1.25 && x < 1.5) pixelScale = 1;
    if (x >= 1.5 && x < 1.75) pixelScale = 2;
    if (x >= 1.75) pixelScale = 3;
  }

  static TextStyle _textStyle(double fontSize) {
    return GoogleFonts.roboto(
      fontSize: fontSize,
      fontStyle: FontStyle.normal,
      fontWeight: FontWeight.normal,
      color: ColorPalette.black,
    );
  }

  static TextStyle get headline4 {
    return _textStyle(30 + pixelScale).copyWith(fontWeight: FontWeight.bold);
  }

  static TextStyle get headline5 {
    return _textStyle(24 + pixelScale).copyWith(fontWeight: FontWeight.bold);
  }

  static TextStyle get headline6 {
    return _textStyle(20 + pixelScale).copyWith(fontWeight: FontWeight.bold);
  }

  static TextStyle get subTitle1 {
    return _textStyle(22 + pixelScale);
  }

  static TextStyle get subTitle2 {
    return _textStyle(18 + pixelScale);
  }

  static TextStyle get bodyText1 {
    return _textStyle(16 + pixelScale);
  }

  static TextStyle get bodyText2 {
    return _textStyle(14 + pixelScale);
  }

  static TextStyle get caption {
    return _textStyle(12).copyWith(color: ColorPalette.grey);
  }
}
