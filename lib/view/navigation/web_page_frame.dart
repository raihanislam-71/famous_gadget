import 'package:flutter/material.dart';

import 'web_site_header.dart';

class WebPageFrame extends StatelessWidget {
  const WebPageFrame({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          const WebSiteHeader(isHome: false),
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final contentWidth = constraints.maxWidth > 1328
                    ? 1280.0
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
