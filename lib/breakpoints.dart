import 'package:flutter/material.dart';

const double webContentMaxWidth = 1280;
const double webContentHorizontalPadding = 20;
const double webPageFrameCenterBreakpoint = 1328;

double webHeaderAlignedTitleSpacing(BuildContext context) {
  final width = MediaQuery.sizeOf(context).width;
  final headerInset =
      width > webContentMaxWidth + 2 * webContentHorizontalPadding
      ? (width - webContentMaxWidth) / 2
      : webContentHorizontalPadding;
  final pageFrameInset = width > webPageFrameCenterBreakpoint
      ? (width - webContentMaxWidth) / 2
      : 0.0;
  return headerInset - pageFrameInset;
}

extension BreakpointUtils on BuildContext {
  bool get isMobile => MediaQuery.of(this).size.width < 700;
  bool get isTablet =>
      MediaQuery.of(this).size.width >= 700 &&
      MediaQuery.of(this).size.width < 1100;
  bool get isDesktop => MediaQuery.of(this).size.width >= 1100;
}
