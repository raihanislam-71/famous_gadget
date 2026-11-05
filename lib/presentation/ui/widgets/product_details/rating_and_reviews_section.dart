import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RatingAndReviewsSection extends StatelessWidget {
  const new({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RatingBarIndicator(
          rating: 4.5,
          itemBuilder: (context, index) =>
          const Icon(Icons.star, color: Colors.amber),
          itemSize: 20,
          direction: Axis.horizontal,
        ),
        const SizedBox(width: 8),
        const Text(
          "4.5",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        const SizedBox(width: 8),
        const Text(
          "(142 Reviews)",
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }
}
