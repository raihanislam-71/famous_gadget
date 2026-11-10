import 'package:bdcalling_class/models/review.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:intl/intl.dart';

class ReviewCard extends StatelessWidget {
  const ReviewCard({super.key, required this.review});

  final Review review;

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
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF17191D),
                    ),
                  ),
                ),
                const SizedBox(width: 4),
                RatingBarIndicator(
                  rating: review.rating.toDouble(),
                  itemCount: 5,
                  itemSize: 13,
                  unratedColor: const Color(0xFFE7E9ED),
                  itemBuilder: (context, index) =>
                      const Icon(Icons.star, color: Color(0xFFFF8A00)),
                ),
                const SizedBox(width: 5),
                Text(
                  DateFormat('dd MMM yyyy').format(review.date),
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF777D87),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 7),
            Text(
              review.reviewText,
              style: const TextStyle(
                fontSize: 13,
                height: 1.5,
                color: Color(0xFF30343A),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
