import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_mage/core/widgets/gradient.dart';
import 'package:movies_mage/core/widgets/shimmer/curser_slider_shimmer.dart';
import 'package:movies_mage/core/widgets/shimmer/home_shimmer.dart';
import 'package:movies_mage/features/details/cupit/details_cubit.dart';
import 'package:movies_mage/features/details/details_view.dart';


class CarouseSlider extends StatelessWidget {
  final List<Map<String, dynamic>> posters;

  const CarouseSlider({super.key, required this.posters});
  @override
  Widget build(BuildContext context) {
    if (posters.isEmpty) {
      return HomeShimmerScreen();
    }
    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: posters.length,
          options: CarouselOptions(
            height: MediaQuery.of(context).size.height * 0.7,
            autoPlay: true,
            enlargeCenterPage: true,
            viewportFraction: 1,
            aspectRatio: 16 / 9,
            autoPlayInterval: const Duration(seconds: 2),
            onPageChanged: (index, reason) {},
          ),
          itemBuilder: (context, index, realIdx) {
            final poster = posters[index];
            final String posterPath = poster['posterPath'] ?? '';
            final int movieId = poster['movieId'] ?? 0;
            final String contentType = poster['contentType'] ?? '';

            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) =>
                          DetailsCubit()..getDetails(movieId, contentType),
                      child: DetailsScreen(
                        contentType: contentType,
                        id: movieId,
                      ),
                    ),
                  ),
                );
              },
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/original$posterPath',
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height *
                          0.7, // match carousel height
                      placeholder: (context, url) => SizedBox(
                        width: double.infinity,
                        height: MediaQuery.of(context).size.height *
                            0.7, // same height
                        child: const CarouseSliderShimmer(),
                      ),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                  ),
                  ImageGradient(),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
