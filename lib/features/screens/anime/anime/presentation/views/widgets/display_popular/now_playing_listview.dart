import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/listviews/movies_listview.dart';
import 'package:movies_mage/core/widgets/listviews/movies_shimmer_listview.dart';
import 'package:movies_mage/features/screens/anime/anime/presentation/manger/popular_cubits/popular_anime_cubit.dart';


class NowPlayingAnimeListview extends StatelessWidget {
  const NowPlayingAnimeListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PopularAnimeCubit()..fetchNowPlayingAnime(),
      child: BlocBuilder<PopularAnimeCubit, PopularAnimeState>(
        builder: (context, state) {
          if (state is NowPlayingAnimeLoading) {
            return const MoviesCardShimmerListView();
          } else if (state is NowPlayingAnimeLoaded) {
            return MoviesListView(
              items: state.anime,
              contentType: 'anime',
            );
          } else if (state is NowPlayingAnimeFailed) {
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
