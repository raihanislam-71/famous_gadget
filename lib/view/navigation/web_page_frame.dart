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
          const WebSiteHeader(),
          Expanded(child: child),
        ],
      ),
    );
  }
}
