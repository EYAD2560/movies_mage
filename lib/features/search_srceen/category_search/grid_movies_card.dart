import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/features/details/presentation/manger/details/details_cubit.dart';
import 'package:movies_mage/features/details/presentation/views/details_view.dart';

class GridMoviesCard extends StatelessWidget {
  final String? poster;
  final String? name;
  final String? rate;
  final int movieId;
  final String contenttype;

  const GridMoviesCard({
    super.key,
    required this.poster,
    required this.name,
    required this.rate,
    required this.movieId,
    required this.contenttype,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (_) => DetailsCubit()..getDetails(movieId, contenttype),
              child: DetailsScreen(
                contentType: contenttype,
                id: movieId,
              ),
            ),
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Poster
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: CachedNetworkImage(
                imageUrl: 'https://image.tmdb.org/t/p/original$poster',
                fit: BoxFit.cover,
                width: double.infinity,
                placeholder: (context, url) =>
                    Container(color: Colors.blueGrey),
                errorWidget: (context, url, error) =>
                    Image.asset('assets/empty image .jpg', fit: BoxFit.cover),
              ),
            ),
          ),

          const SizedBox(height: 6),

          // Title
          Text(
            name ?? 'No Title',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 13,
              decoration: TextDecoration.none,
              color: Colors.white,
            ),
          ),

          const SizedBox(height: 2),

          // Rating
          Row(
            children: [
              const Icon(Icons.star, size: 14, color: Colors.amber),
              const SizedBox(width: 4),
              Text(
                rate ?? '0.0',
                style: const TextStyle(
                    fontSize: 12,
                    decoration: TextDecoration.none,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
