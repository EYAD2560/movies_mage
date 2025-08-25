import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AllMoviesCardShimmer extends StatelessWidget {
  const AllMoviesCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xff2a2f38); // Slightly lighter for better contrast
    const highlightColor = Color(0xff3a404a);

    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xff20252d),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          // Image shimmer
          Shimmer.fromColors(
            baseColor: baseColor,
            highlightColor: highlightColor,
            child: Container(
              width: 120,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
          const SizedBox(width: 12),

          // Text + genres + rating shimmer
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    height: 20,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // Description
                Shimmer.fromColors(
                  baseColor: baseColor,
                  highlightColor: highlightColor,
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
                const SizedBox(height: 12),

                // Genre tags
                Row(
                  children: List.generate(2, (_) {
                    return Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: Container(
                        margin: const EdgeInsets.only(right: 8),
                        width: 60,
                        height: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 12),

                // Rating
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.grey.shade700, size: 16),
                    const SizedBox(width: 4),
                    Shimmer.fromColors(
                      baseColor: baseColor,
                      highlightColor: highlightColor,
                      child: Container(
                        height: 14,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
