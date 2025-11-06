import 'package:flutter/material.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/cards/movies_card.dart';

class MoviesListView extends StatelessWidget {
  const MoviesListView({super.key, required this.items, required this.contentType, });

  final List<GlobalModel> items;
final String contentType ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: SizedBox(
        height: 300,
        child: ListView.builder(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            final item = items[index];
            return MoviesCard(
              movieId: item.id,
              poster: item.poster,
              name: item.name,
              rate: item.rate,
              contenttype: contentType,
            );
          },
        ),
      ),
    );
  }
}
