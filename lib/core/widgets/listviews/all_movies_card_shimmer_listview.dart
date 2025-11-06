import 'package:flutter/material.dart';
import 'package:movies_mage/shimmer/all_movies_card_shimmer.dart';

class AllMoviessCardShimmerListView extends StatelessWidget {
  const AllMoviessCardShimmerListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      itemCount: 10,
      itemBuilder: (context, index) => AllMoviesCardShimmer(),
    );
  }
}