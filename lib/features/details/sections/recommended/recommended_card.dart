import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/features/details/cupit/details_cubit.dart';
import 'package:movies_mage/features/details/details_view.dart';

class RecommendedCard extends StatelessWidget {
  final String? poster;
  final String? name;
  final String? rate;
  final int movieId;
  final String contenttype;

  const RecommendedCard({
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
              child: DetailsScreen(contentType: contenttype, id: movieId),
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 8, left: 16),
        child: Container(
          width: 170,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: CachedNetworkImage(
              imageUrl: (poster != null && poster!.isNotEmpty)
                  ? 'https://image.tmdb.org/t/p/original$poster'
                  : 'https://via.placeholder.com/200x300.png?text=No+Image',
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 250,
                width: 170,
                color: Colors.blueGrey,
              ),
              errorWidget: (context, url, error) =>
                  Image.asset('assets/empty image .jpg'),
            ),
          ),
        ),
      ),
    );
  }
}
