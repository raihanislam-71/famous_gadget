import 'package:flutter/material.dart';

class WebWebContent extends StatelessWidget {
  const WebWebContent({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 1280),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width > 1360 ? 0 : 24,
            vertical: 36,
          ),
          child: child,
        ),
      ),
    );
  }
}

class WebSectionBand extends StatelessWidget {
  const WebSectionBand({super.key, required this.child, this.shaded = false});

  final Widget child;
  final bool shaded;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: shaded
          ? (Theme.of(context).brightness == Brightness.dark
                ? const Color(0xFF111827)
                : const Color(0xFFF3F5FA))
          : Theme.of(context).scaffoldBackgroundColor,
      child: child,
    );
  }
}
