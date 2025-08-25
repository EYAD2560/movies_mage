import 'package:flutter/material.dart';
import 'package:movies_mage/widgets/cards/all_movies_card.dart';
import 'package:movies_mage/core/global_model.dart';

class SearchResults extends StatelessWidget {
  final List<GlobalModel> movies;
  final List<GlobalModel> tvShows;

  const SearchResults({
    super.key,
    required this.movies,
    required this.tvShows,
  });

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      physics: const BouncingScrollPhysics(),
      children: [
        _buildListView(movies, "No movies found"),
        _buildListView(tvShows, "No TV shows found"),
      ],
    );
  }

  Widget _buildListView(
    List<GlobalModel> items,
    String emptyMessage,
  ) {
    if (items.isEmpty) {
      return Center(
        child: Text(
          emptyMessage,
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
   else {
      return Expanded(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true, // ده بيمنع unbounded height
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return AllMoviesCard(
              poster: item.poster,
              name: item.name,
              rate: item.rate,
              overview: item.overview,
              genres: item.genres,
              movieId: item.id,
              contentType: item.mediaType,
            );
          },
        ),
      );
    }
  }
}
