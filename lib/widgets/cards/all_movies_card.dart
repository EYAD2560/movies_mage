import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/details/cupit/details_cubit.dart';
import 'package:movies_mage/details/details_view.dart';
import 'package:movies_mage/widgets/gernes/genre_chips.dart';

class AllMoviesCard extends StatelessWidget {
  final String poster;
  final String name;
  final String rate;
  final String overview;
  final List<String> genres;
  final int movieId;
  final String contentType;

  const AllMoviesCard({
    super.key,
    required this.poster,
    required this.name,
    required this.rate,
    required this.overview,
    required this.genres,
    required this.movieId,
    required this.contentType,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => DetailsCubit()..getDetails(movieId, contentType),
              child: DetailsScreen(contentType: contentType, id: movieId),
            ),
          ),
        );
      },
      child: Material(
        color: Colors.black,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 200,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Poster
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/original$poster',
                  height: double.infinity,
                  width: 120,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      Container(height: 250, color: Colors.blueGrey),
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/empty image .jpg'),
                ),
              ),
              const SizedBox(width: 12),

              // Info section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                      maxLines: 2,
                    ),
                    const SizedBox(height: 4),

                    // Overview
                    SizedBox(
                      height: 60,
                      child: Text(
                        overview,
                        maxLines: 6,
                        overflow: TextOverflow.fade,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),

                    GenreChips(genres: genres),
                    const SizedBox(height: 8),

                    // Rating
                    Text(
                      '⭐ $rate',
                      style: const TextStyle(color: Colors.amber, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
