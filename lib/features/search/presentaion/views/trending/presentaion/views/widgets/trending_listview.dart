import 'package:flutter/material.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/features/search/presentaion/views/widgets/trending_cards.dart';

class TrendingMoviesListView extends StatelessWidget {
  const TrendingMoviesListView({
    super.key,
    required this.items,
    required this.contentType,
  });

  final List<GlobalModel> items;
  final String contentType;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          final item = items[index];
          return TrendingCards(
            poster: item.poster,
            name: item.name,
            rate: item.rate,
            contentType: contentType,
            movieId: item.id,
          );
        },
      ),
    );
  }
}
