// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/features/details/cupit/details_cubit.dart';
import 'package:movies_mage/features/details/details_view.dart';

class MoviesCard extends StatelessWidget {
  // Movie poster path (can be null)
  final String? poster;

  // Movie name/title (can be null)
  final String? name;

  // Movie rating (example: 8.4)
  final String? rate;

  // Movie ID to fetch details from TMDB
  final int movieId;

  // Content type (e.g., "movie", "tv", "anime")
  final String contenttype;

  const MoviesCard({
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
      child: Padding(
        padding: const EdgeInsets.only(right: 8, left: 16),
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
          ),
          child: Stack(
            children: [
              // === Movie Poster ===
              ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: CachedNetworkImage(
                  imageUrl: 'https://image.tmdb.org/t/p/original$poster',
                  fit: BoxFit.fill,
                  errorWidget: (context, url, error) =>
                      Image.asset('assets/empty image .jpg'),
                ),
              ),
              // === Blurred Footer ===
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                    child: Container(
                      height: 65,
                      decoration: BoxDecoration(
                      
                        color: Colors.black.withOpacity(0.4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Title
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Text(
                                name ?? 'No Title',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          // Rating
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Text(
                              '${rate ?? '0'}⭐',
                              style: const TextStyle(
                                color: Colors.yellow,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
