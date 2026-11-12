import 'package:flutter/material.dart';

class WebSectionHeading extends StatelessWidget {
  const WebSectionHeading({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onSeeAll,
  });

  final String title;
  final String subtitle;
  final VoidCallback onSeeAll;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.headlineSmall
                      ?.copyWith(fontSize: 28, fontWeight: FontWeight.w800),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          if (constraints.maxWidth > 420)
            TextButton(
              onPressed: onSeeAll,
              child: const Row(
                children: [
                  Text('See all'),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 18),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
