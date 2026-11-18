import 'package:flutter/material.dart';

import '../../breakpoints.dart';
import 'web_site_header.dart';

class WebPageFrame extends StatelessWidget {
  const WebPageFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.sizeOf(context).width >= 1100;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          if (isDesktop) const WebSiteHeader(),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final contentWidth =
                    constraints.maxWidth > webPageFrameCenterBreakpoint
                    ? webContentMaxWidth
                    : constraints.maxWidth;
                return Center(
                  child: SizedBox(
                    width: contentWidth,
                    height: constraints.maxHeight,
                    child: child,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
