import 'package:flutter/material.dart';

class TextStyleTheme {

  static TextStyle customTextStyle(Color color, double size, FontWeight fontWeight, {double? spacing, TextDecoration? decoration, String? fontFamily}) {
    return TextStyle(
        fontFamily: fontFamily ?? "Montserrat", //Your font name
        color: color,
        fontSize: size,
        fontWeight: fontWeight,
        decoration: decoration ?? TextDecoration.none, letterSpacing: spacing ?? 0);
  }
}