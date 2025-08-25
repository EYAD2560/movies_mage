import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class MoviesCardShimmer extends StatelessWidget {
  const MoviesCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xff2a2f38); // Same as other shimmers
    const highlightColor = Color(0xff3a404a);

    return Padding(
      padding: const EdgeInsets.only(right: 8, left: 16),
      child: Shimmer.fromColors(
        baseColor: baseColor,
        highlightColor: highlightColor,
        child: Container(
          height: 300,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
