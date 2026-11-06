import 'package:flutter/material.dart';

extension WidgetExtension on Widget {
  Widget paddingAll(double padding) => Padding(
        padding: EdgeInsets.all(padding),
        child: this,
      );

  Widget paddingSymmetric({double horizontal = 0.0, double vertical = 0.0}) =>
      Padding(
        padding:
            EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical),
        child: this,
      );

  Widget padOnly({
    double left = 0.0,
    double top = 0.0,
    double right = 0.0,
    double bottom = 0.0,
  }) =>
      Padding(
        padding:
            EdgeInsets.only(top: top, left: left, right: right, bottom: bottom),
        child: this,
      );

  Widget center() => Center(child: this);

  Widget visible(bool visible, {Widget? fallback}) =>
      visible ? this : (fallback ?? const SizedBox.shrink());
}

extension ContextExtension on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  TextTheme get textTheme => Theme.of(this).textTheme;
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}

extension NavigatorExtension on BuildContext {
  void navigateTo(Widget screen) => Navigator.push(this, MaterialPageRoute(builder: (_) => screen));
  void navigateAndRemoveUntil(Widget screen) => Navigator.pushAndRemoveUntil(
      this, MaterialPageRoute(builder: (_) => screen), (route) => false);
}
