import 'package:flutter/material.dart';

class StatusPill extends StatelessWidget {
  const StatusPill(
    this.text,
    this.color, {
    super.key,
    this.isSolid = false,
  });

  final String text;
  final Color color;
  final bool isSolid;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isSolid ? color : color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSolid ? Colors.white : color,
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
