import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/listviews/movies_listview.dart';
import 'package:movies_mage/core/widgets/listviews/movies_shimmer_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/presentation/manger/japanese_cubits/japanese_anime_cubit.dart';


class JapaneseAnimeListview extends StatelessWidget {
  const JapaneseAnimeListview({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (_) => JapaneseAnimeCubit()..fetchJapaneseAnime(),
      child: BlocBuilder<JapaneseAnimeCubit, JapaneseAnimeState>(
        builder: (context, state) {
          if (state is JapaneseAnimeLoading) {
            return const MoviesCardShimmerListView();
          } else if (state is JapaneseAnimeLoaded) {
            return MoviesListView(
              items: state.anime,
              contentType: 'anime',
            );
          } else if (state is JapaneseAnimeFailed) {
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
