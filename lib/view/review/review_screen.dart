import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:bdcalling_class/controllers/review_controller.dart';
import 'package:get/get.dart';

import 'widgets/review_card.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key, required this.productId});

  final String productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      appBar: AppBar(
        title: const Text('All Reviews'),
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 14),
            child: _buildRatingOverview(),
          ),
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
            child: Row(
              children: [
                _buildSortOption('Most Recent'),
                const SizedBox(width: 8),
                _buildSortOption('Highest Rating'),
                const SizedBox(width: 8),
                _buildSortOption('Lowest Rating'),
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

  Widget _buildRatingOverview() {
    const breakdown = [
      (stars: 5, percentage: 70),
      (stars: 4, percentage: 18),
      (stars: 3, percentage: 7),
      (stars: 2, percentage: 3),
      (stars: 1, percentage: 2),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFE7E9ED)),
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
                const Text(
                  '4.8',
                  style: TextStyle(
                    fontSize: 34,
                    height: 1,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF17191D),
                  ),
                ),
                const SizedBox(height: 6),
                RatingBarIndicator(
                  rating: 5,
                  itemCount: 5,
                  itemSize: 13,
                  unratedColor: const Color(0xFFE7E9ED),
                  itemBuilder: (context, index) =>
                      const Icon(Icons.star, color: Color(0xFFFF8A00)),
                ),
                const SizedBox(height: 4),
                const Text(
                  '142 Reviews',
                  style: TextStyle(fontSize: 10, color: Color(0xFF777D87)),
                ),
              ],
            ),
          ),
          Container(width: 1, height: 78, color: const Color(0xFFE9EBEF)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              children: [
                for (final item in breakdown)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 12,
                          child: Text(
                            '${item.stars}',
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF454A52),
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
                              value: item.percentage / 100,
                              minHeight: 4,
                              backgroundColor: const Color(0xFFF0F1F3),
                              valueColor: const AlwaysStoppedAnimation(
                                Color(0xFFFF8A00),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 26,
                          child: Text(
                            '${item.percentage}%',
                            textAlign: TextAlign.end,
                            style: const TextStyle(
                              fontSize: 10,
                              color: Color(0xFF777D87),
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

  Widget _buildSortOption(String label) {
    return GetBuilder<ReviewController>(
      builder: (controller) {
        final isSelected = controller.selectedSort == label;
        return Expanded(
          child: Material(
            color: isSelected ? const Color(0xFFFFF5EF) : Colors.white,
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
                        ? const Color(0xFFFF7A35)
                        : const Color(0xFFE6E8EC),
                  ),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? const Color(0xFFE85F1A)
                        : const Color(0xFF30343A),
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
