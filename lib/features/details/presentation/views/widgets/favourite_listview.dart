// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/cards/all_movies_card.dart';
import 'package:movies_mage/core/widgets/shimmer/all_movies_card_shimmer.dart';

class FavouriteListView extends StatelessWidget {
  const FavouriteListView({
    super.key,
    required this.scrollController,
    required this.items,
    this.showShimmer = false,
  });

  final ScrollController scrollController;
  final List<GlobalModel> items;
  final bool showShimmer;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true, // ✅ let it size itself to content
      controller: scrollController,
      physics: const BouncingScrollPhysics(),
      itemCount: showShimmer ? items.length + 1 : items.length,
      itemBuilder: (context, index) {
        if (index < items.length) {
          final item = items[index];
          return AllMoviesCard(
            poster: item.poster,
            name: item.name,
            rate: item.rate,
            overview: item.overview,
            genres: item.genres,
            movieId: item.id,
            contentType:  item.mediaType,
          );
        } else {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: AllMoviesCardShimmer(),
          );
        }
      },
    );
  }
}
