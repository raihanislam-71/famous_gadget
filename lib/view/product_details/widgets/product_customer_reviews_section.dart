import 'package:flutter/material.dart';
import '../../../controllers/review_controller.dart';
import '../../../models/product.dart';
import '../../navigation/app_navigation.dart';
import '../../review/review_screen.dart';
import '../../utils/app_colors.dart';
import 'product_review_card.dart';
import 'rating_and_reviews_section.dart';

class ProductCustomerReviewsSection extends StatelessWidget {
  const ProductCustomerReviewsSection({
    super.key,
    required this.product,
    required this.reviewController,
  });

  final Product product;
  final ReviewController reviewController;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final reviews = reviewController.previewReviews;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.rate_review_outlined,
                    color: AppColors.primary,
                    size: 22,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    'Customer Reviews',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              const RatingAndReviewsSection(),
            ],
          ),
          const SizedBox(height: 20),
          ...reviews.map((rev) {
            return ProductReviewCard(review: rev, isDesktop: true);
          }),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => AppRoutes.to<void>(
                route: AppRoutes.reviews,
                arguments: {'productId': product.id},
                mobileBuilder: () => ReviewScreen(productId: product.id),
              ),
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.primary),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'See All Reviews',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
