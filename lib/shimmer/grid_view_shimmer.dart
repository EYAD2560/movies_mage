import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class GridMoviesCardShimmer extends StatelessWidget {
  const GridMoviesCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xff2a2f38); // Same as AllMoviesCardShimmer
    const highlightColor = Color(0xff3a404a);

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster box
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 6),

          // Title placeholder
          Container(
            height: 14,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 6),

          // Rating placeholder
          Container(
            height: 12,
            width: 40,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(6),
            ),
          ),
        ],
      ),
    );
  }
}
