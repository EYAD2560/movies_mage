import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/listviews/movies_listview.dart';
import 'package:movies_mage/core/widgets/listviews/movies_shimmer_listview.dart';
import 'package:movies_mage/screens/anime/anime/display_english/display_japanese/cubit/english_anime_cubit.dart';


class EnglishAnimeListview extends StatelessWidget {
  const EnglishAnimeListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EnglishAnimeCubit()..fetchEnglishAnime(),
      child: BlocBuilder<EnglishAnimeCubit, EnglishAnimeState>(
        builder: (context, state) {
          if (state is EnglishAnimeLoading) {
            return const MoviesCardShimmerListView();
          } else if (state is EnglishAnimeLoaded) {
            return MoviesListView(
              items: state.anime,
              contentType: 'anime',
            );
          } else if (state is EnglishAnimeFailed) {
            return Center(child: Text(state.errorMessage));
          } else {
            // Default empty fallback
            return MoviesListView(
              items: List.generate(5, (_) => GlobalModel.empty()),
              contentType: 'anime',
            );
          }
        },
      ),
    );
  }
}
