import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import '../../../controllers/review_controller.dart';
import '../../utils/app_colors.dart';

class RatingAndReviewsSection extends StatelessWidget {
  const RatingAndReviewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reviews = Get.isRegistered<ReviewController>()
        ? Get.find<ReviewController>()
        : Get.put(ReviewController());

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingBarIndicator(
          rating: reviews.averageRating,
          itemBuilder: (context, index) =>
              const Icon(Icons.star_rounded, color: AppColors.amber),
          itemSize: 18,
          direction: Axis.horizontal,
          unratedColor: theme.colorScheme.surfaceContainerHighest,
        ),
        const SizedBox(width: 8),
        Text(
          reviews.averageRating.toStringAsFixed(1),
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '(${reviews.reviews.length} Reviews)',
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
