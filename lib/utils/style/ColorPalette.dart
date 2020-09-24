import 'package:flutter/material.dart';

class ColorPalette {

  static Color fromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return Color(int.parse(hexColor, radix: 16));
  }

  static Color get primaryColor => Color(0xFFDE5858);
  static Color get secondaryColor => Color(0xFF434651);
  static Color get black => Color(0xFF222222);
  static Color get grey => Color(0xFF808080);
}