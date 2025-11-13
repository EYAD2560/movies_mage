// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/features/details/presentation/manger/details/details_cubit.dart';
import 'package:movies_mage/features/details/presentation/views/widgets/person_detalis/data/person_model.dart';
import 'package:movies_mage/features/details/presentation/views/details_view.dart';

class ShowsTheyParticipatedInCard extends StatelessWidget {
  final MediaWork work;
  final int movieId;
  final String contenttype;
  const ShowsTheyParticipatedInCard({
    super.key,
    required this.work,
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
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: CachedNetworkImage(
              imageUrl: work.posterPath,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (context, url) => Container(color: Colors.blueGrey),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                child: Container(
                  padding: const EdgeInsets.all(6),
                  color: Colors.black.withOpacity(0.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        work.title,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
