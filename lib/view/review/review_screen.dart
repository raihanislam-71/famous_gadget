import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:famous_gadget/controllers/review_controller.dart';
import 'package:get/get.dart';

import '../navigation/app_navigation.dart';
import 'widgets/review_card.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    final isWeb = kIsWeb;
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('All Reviews'),
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        surfaceTintColor: theme.colorScheme.surface,
        elevation: 0,
        automaticallyImplyLeading: !isWeb,
        leading: isWeb
            ? null
            : IconButton(
                icon: const Icon(CupertinoIcons.back),
                onPressed: () {
                  if (Navigator.of(context).canPop()) {
                    Navigator.of(context).pop();
                  } else {
                    AppRoutes.backToHome();
                  }
                },
              ),
      ),
      body: Column(
        children: [
          Container(
            color: theme.colorScheme.surface,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: _buildRatingOverview(
              context,
              Get.find<ReviewController>(),
            ),
          ),
          Container(
            color: theme.colorScheme.surface,
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Row(
              children: [
                _buildSortOption(context, 'Most Recent'),
                const SizedBox(width: 8),
                _buildSortOption(context, 'Highest Rating'),
                const SizedBox(width: 8),
                _buildSortOption(context, 'Lowest Rating'),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: GetBuilder<ReviewController>(
              builder: (controller) => ListView.builder(
                padding: const EdgeInsets.only(top: 8),
                itemCount: controller.sortedReviews.length,
                itemBuilder: (context, index) =>
                    ReviewCard(review: controller.sortedReviews[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRatingOverview(
    BuildContext context,
    ReviewController controller,
  ) {
    final theme = Theme.of(context);
    final reviewCount = controller.reviews.length;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        border: Border.all(color: theme.dividerColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 86,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  controller.averageRating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 38,
                    height: 1,
                    fontWeight: FontWeight.w700,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 6),
                RatingBarIndicator(
                  rating: controller.averageRating,
                  itemCount: 5,
                  itemSize: 15,
                  unratedColor: theme.colorScheme.surfaceContainerHighest,
                  itemBuilder: (context, index) =>
                      const Icon(Icons.star, color: Color(0xFFFF8A00)),
                ),
                const SizedBox(height: 4),
                Text(
                  '$reviewCount Reviews',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 78, color: theme.dividerColor),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                for (var stars = 5; stars >= 1; stars--)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                          child: Text(
                            '$stars',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                        ),
                        const Icon(
                          Icons.star,
                          size: 11,
                          color: Color(0xFFFF8A00),
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(3),
                            child: LinearProgressIndicator(
                              value: reviewCount == 0
                                  ? 0
                                  : controller.getRatingCount(stars) /
                                        reviewCount,
                              minHeight: 5,
                              backgroundColor:
                                  theme.colorScheme.surfaceContainerHighest,
                              valueColor: const AlwaysStoppedAnimation(
                                Color(0xFFFF8A00),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 34,
                          child: Text(
                            '${reviewCount == 0 ? 0 : (controller.getRatingCount(stars) * 100 / reviewCount).round()}%',
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(BuildContext context, String label) {
    return GetBuilder<ReviewController>(
      builder: (controller) {
        final isSelected = controller.selectedSort == label;
        final theme = Theme.of(context);
        return Expanded(
          child: Material(
            color: isSelected
                ? theme.colorScheme.primary.withValues(alpha: 0.12)
                : theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(18),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),
              onTap: () => controller.setSortOption(label),
              child: Container(
                alignment: Alignment.center,
                constraints: const BoxConstraints(minHeight: 34),
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 7),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.dividerColor,
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurface,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
