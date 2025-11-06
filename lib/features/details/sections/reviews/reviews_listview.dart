import 'package:flutter/material.dart';
import 'package:movies_mage/features/details/sections/reviews/expanded_reviews.dart';
import 'package:movies_mage/features/details/sections/reviews/reviews_model.dart';
import 'package:movies_mage/features/details/sections/reviews/reviews_service.dart';

/// This widget shows all reviews for a movie/TV show
class ReviewsSection extends StatelessWidget {
  final int id;
  final String contentType;

  const ReviewsSection({
    super.key,
    required this.id,
    required this.contentType,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ReviewsModel>>(
      future: ReviewService().fetchReviews(id: id, contentType: contentType),
      builder: (context, snapshot) {
        final reviews = snapshot.data ?? [];

        if (reviews.isEmpty) {
          return const SizedBox.shrink(); // Show nothing if no reviews
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row with title and count
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Reviews',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '${reviews.length} Reviews',
                  style: const TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // List of expandable reviews
            ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ExpandableReview(review: reviews[index]);
              },
            ),
          ],
        );
      },
    );
  }
}

