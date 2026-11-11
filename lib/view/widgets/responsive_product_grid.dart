import 'package:flutter/material.dart';

class ResponsiveProductGrid extends StatelessWidget {
  const ResponsiveProductGrid({
    super.key,
    required this.itemCount,
    required this.itemBuilder,
  });

  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 900
        ? 4
        : screenWidth > 600
        ? 3
        : 2;
    final horizontalSpacing = 12.0;
    final availableWidth =
        screenWidth - 24 - horizontalSpacing * (crossAxisCount - 1);
    final itemWidth = availableWidth / crossAxisCount;
    final childAspectRatio = itemWidth < 228 ? itemWidth / 240 : 0.95;

    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: horizontalSpacing,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: itemBuilder,
    );
  }
}
