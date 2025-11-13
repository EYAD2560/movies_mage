import 'package:flutter/material.dart';
import 'package:movies_mage/core/widgets/shimmer/grid_view_shimmer.dart';

class GridMoviesCardShimmerListview extends StatelessWidget {
  const GridMoviesCardShimmerListview({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 12,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 0.55,
        ),
        itemBuilder: (context, index) => const GridMoviesCardShimmer(),
      ),
    );
  }
}
