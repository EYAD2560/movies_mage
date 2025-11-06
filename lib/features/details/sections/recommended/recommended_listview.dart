import 'package:flutter/material.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/shimmer/recommended_card_shimmer.dart';
import 'package:movies_mage/features/details/sections/recommended/recommended_service.dart';
import 'package:movies_mage/features/details/sections/recommended/recommended_card.dart';

class RecommendedSection extends StatelessWidget {
  final int id;
  final String contentType;

  const RecommendedSection({
    super.key,
    required this.id,
    required this.contentType,
  });

  @override
  Widget build(BuildContext context) {
    final fetchRecommendedService = FetchRecommendedService();

    return FutureBuilder<List<GlobalModel>>(
      future: fetchRecommendedService.fetchRecommended(
        id: id,
        contentType: contentType,
      ),
      builder: (context, snapshot) {
        // Show shimmer while loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recommended",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: const NeverScrollableScrollPhysics(),
                child: Row(
                  children: List.generate(
                    3, // Number of shimmer cards
                    (index) => const RecommendedCardShimmer(),
                  ),
                ),
              ),
            ],
          );
        }

        // If there's an error or no data -> hide the section completely
        if (snapshot.hasError || snapshot.data!.isEmpty) {
          return const SizedBox.shrink();
        }

        // Success -> show the recommended list
        final recommended = snapshot.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recommended",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 300,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: recommended.length,
                itemBuilder: (context, index) {
                  final movie = recommended[index];
                  return RecommendedCard(
                    poster: movie.poster,
                    name: movie.name,
                    rate: movie.rate,
                    movieId: movie.id,
                    contenttype: contentType,
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
