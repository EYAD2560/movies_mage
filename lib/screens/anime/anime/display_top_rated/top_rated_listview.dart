import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/screens/anime/anime/display_top_rated/cubit/top_rated_cubit.dart';
import 'package:movies_mage/widgets/listviews/movies_listview.dart';
import 'package:movies_mage/widgets/listviews/movies_shimmer_listview.dart';

class TopRatedAnimeListview extends StatelessWidget {
  const TopRatedAnimeListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopRatedAnimeCubit()..fetchTopRatedAnime(),
      child: BlocBuilder<TopRatedAnimeCubit, TopRatedAnimeState>(
        builder: (context, state) {
          if (state is TopRatedAnimeLoading) {
            return const MoviesCardShimmerListView();
          } else if (state is TopRatedAnimeLoaded) {
            return MoviesListView(
              items: state.anime,
              contentType: 'anime',
            );
          } else if (state is TopRatedAnimeFailed) {
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
