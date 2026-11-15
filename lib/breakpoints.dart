import 'package:flutter/material.dart';

extension BreakpointUtils on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 700;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 700 &&
      MediaQuery.of(this).size.width < 1100;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1100;
}
