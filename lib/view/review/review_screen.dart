import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class Review {
  final String name;
  final int rating;
  final String reviewText;
  final DateTime date;
  final bool isMostRecent;

  Review({
    required this.name,
    required this.rating,
    required this.reviewText,
    required this.date,
    this.isMostRecent = false,
  });
}

class ReviewCard extends StatelessWidget {
  final Review review;

  const ReviewCard({super.key, required this.review});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xFFE6E8EC)),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    review.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF17191D),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                RatingBarIndicator(
                  rating: review.rating.toDouble(),
                  itemCount: 5,
                  itemSize: 10,
                  unratedColor: const Color(0xFFE7E9ED),
                  itemBuilder: (context, index) =>
                      const Icon(Icons.star, color: Color(0xFFFF8A00)),
                ),
                const SizedBox(width: 5),
                Text(
                  DateFormat('dd MMM yyyy').format(review.date),
                  style: const TextStyle(fontSize: 8, color: Color(0xFF777D87)),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              review.reviewText,
              style: const TextStyle(
                fontSize: 10,
                height: 1.4,
                color: Color(0xFF30343A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ReviewScreen extends StatefulWidget {
  const ReviewScreen({super.key, required this.productId});

  final String productId;

  @override
  State<ReviewScreen> createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final List<Review> reviews = [
    Review(
      name: 'Alisha Rahman',
      rating: 5,
      reviewText: 'These are hands-down the best over-ears I have owned. The sound is incredibly detailed, and the battery life is amazing. After a full day of travel, I still had 30% left.',
      date: DateTime(2023, 12, 10),
      isMostRecent: true,
    ),
    Review(
      name: 'Omar Khan',
      rating: 4,
      reviewText: 'Overall, not the case feels a bit larger than I expected, but the sound quality is worth it. Sometimes, the sound quality and ANC are worth it.',
      date: DateTime(2023, 11, 08),
    ),
    Review(
      name: 'Priya Senapati',
      rating: 5,
      reviewText: 'For long flights, the ANC is incredible in loud environments and the battery life easily lasts a full day. Highly recommended for anyone who values silence and comfort.',
      date: DateTime(2023, 11, 05),
    ),
    Review(
      name: 'Rahim Hasan',
      rating: 5,
      reviewText: 'Absolutely fantastic sound signature and the battery life easily lasts more than my continuous usage time. Worth every single rupee spent.',
      date: DateTime(2023, 11, 02),
    ),
    Review(
      name: 'Nadia Islam',
      rating: 4,
      reviewText: 'Excellent noise cancellation and sound, though they are quite pricey. The premium build feels luxurious, but I suggest getting a case.',
      date: DateTime(2023, 10, 28),
    ),
    Review(
      name: 'Tamim Ahmed',
      rating: 3,
      reviewText: 'The ANC is decent, but I expected a bit more punchiness. The build quality is solid, but the bass needs to tweak EQ settings.',
      date: DateTime(2023, 10, 25),
    ),
    Review(
      name: 'Samina Begum',
      rating: 5,
      reviewText: 'The premium build feels amazing. Worth every single rupee spent. Noise cancellation literally blocks out the chaotic city traffic sound completely.',
      date: DateTime(2023, 10, 20),
    ),
  ];

  String _selectedSort = 'Most Recent';

  List<Review> get _sortedReviews {
    final sorted = [...reviews];
    switch (_selectedSort) {
      case 'Highest Rating':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
      case 'Lowest Rating':
        sorted.sort((a, b) => a.rating.compareTo(b.rating));
      default:
        sorted.sort((a, b) => b.date.compareTo(a.date));
    }
    return sorted;
  }

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
            child: ListView.builder(
              padding: const EdgeInsets.only(top: 8),
              itemCount: _sortedReviews.length,
              itemBuilder: (context, index) {
                return ReviewCard(review: _sortedReviews[index]);
              },
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
    final isSelected = _selectedSort == label;
    return Expanded(
      child: Material(
        color: isSelected ? const Color(0xFFFFF5EF) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => setState(() => _selectedSort = label),
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
  }
}
