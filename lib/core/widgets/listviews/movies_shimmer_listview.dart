import 'package:flutter/material.dart';
import 'package:movies_mage/core/widgets/shimmer/movies_card_shimmer.dart';

class MoviesCardShimmerListView extends StatelessWidget {
  const MoviesCardShimmerListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      physics: const NeverScrollableScrollPhysics(),
      child: Row(
        children: List.generate(
          3, // or any number
          (index) => MoviesCardShimmer(),
        ),
      ),
    );
  }
}