import 'package:flutter/material.dart';

class AppTextStyles {
  static const String headingFontFamily = 'Outfit';
  static const String bodyFontFamily = 'Geist';

  static const TextStyle display = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w800,
  );
  static const TextStyle h1 = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w800,
  );
  static const TextStyle h2 = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle uiSemibold = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
  static const TextStyle body = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 14,
    height: 1.5,
  );
  static const TextStyle caption = TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 12,
  );
  static const TextStyle button = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );
  static const TextStyle badge = TextStyle(
    fontFamily: headingFontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w700,
  );
}
