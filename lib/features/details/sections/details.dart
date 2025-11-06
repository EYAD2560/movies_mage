import 'package:flutter/material.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/gernes/genre_chips.dart';
import 'package:movies_mage/features/details/widgets/details_bar.dart';
import 'package:movies_mage/features/details/sections/backdrop.dart';
import 'package:movies_mage/features/details/sections/cast/cast_listview.dart';
import 'package:movies_mage/features/details/sections/overview_section.dart';
import 'package:movies_mage/features/details/sections/rate_releasedate.dart';
import 'package:movies_mage/features/details/sections/recommended/recommended_listview.dart';
import 'package:movies_mage/features/details/sections/reviews/reviews_listview.dart';
import 'package:movies_mage/features/details/sections/trailer_section.dart';

class DetailsBodyStack extends StatelessWidget {
  const DetailsBodyStack({
    super.key,
    required this.model,
  });

  final GlobalModel model;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== Backdrop Image =====
              BackDropSection(backdropPath: model.backdropImage),
    
              // ===== Details Content =====
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    if (model.name.isNotEmpty)
                      Text(
                        model.name,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    const SizedBox(height: 8),
    
                    // Rating + Release Year
                    if (model.rate != "0.0" ||
                        model.releaseDate.isNotEmpty)
                      RateandReleasedata(model: model),
                    const SizedBox(height: 8),
    
                    // Genres
                    if (model.genres.isNotEmpty)
                      GenreChips(genres: model.genres),
                    const SizedBox(height: 25),
    
                    // Action Buttons
                    TrailerSection(model: model),
                    const SizedBox(height: 25),
    
                    // Cast Section
                    CastListView(
                        id: model.id, contentType: model.mediaType),
                    const SizedBox(height: 20),
    
                    // Overview
                    if (model.overview.isNotEmpty) Overview(model: model),
    
                    // Recommended
                    RecommendedSection(
                      id: model.id,
                      contentType: model.mediaType,
                    ),
                    const SizedBox(height: 20),
    
                    // Reviews
                    ReviewsSection(
                      id: model.id,
                      contentType: model.mediaType,
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
    
        // ===== Back Button + Favourite =====
        Positioned(
          top: 16,
          left: 16,
          child: DetailsBar(model: model),
        ),
      ],
    );
  }
}
