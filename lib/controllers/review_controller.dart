import 'package:famous_gadget/models/review.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  bool isExpanded = false;
  String selectedSort = 'Most Recent';

  final List<Review> reviews = [
    Review(
      name: 'Alisha Rahman',
      rating: 5,
      reviewText: 'These are hands-down the best over-ears I have owned. The sound is incredibly detailed, and the battery life is amazing. After a full day of travel, I still had 30% left.',
      date: DateTime(2023, 12, 10),
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

  List<Review> get sortedReviews {
    final sorted = [...reviews];
    switch (selectedSort) {
      case 'Highest Rating':
        sorted.sort((a, b) => b.rating.compareTo(a.rating));
      case 'Lowest Rating':
        sorted.sort((a, b) => a.rating.compareTo(b.rating));
      default:
        sorted.sort((a, b) => b.date.compareTo(a.date));
    }
    return sorted;
  }

  List<Review> get previewReviews => sortedReviews.take(3).toList();

  double get averageRating {
    if (reviews.isEmpty) return 0;
    return reviews.fold<int>(0, (total, review) => total + review.rating) /
        reviews.length;
  }

  int getRatingCount(int rating) =>
      reviews.where((review) => review.rating == rating).length;

  void setSortOption(String value) {
    selectedSort = value;
    update();
  }

  void toggleExpand() {
    isExpanded = !isExpanded;
    update();
  }
}
