import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/listviews/movies_shimmer_listview.dart';
import 'package:movies_mage/features/screens/search_srceen/trending/tvshows/trending_tv_shows_cubit.dart';
import 'package:movies_mage/features/search_srceen/trending/trending_listview.dart';
import 'package:movies_mage/features/search_srceen/trending/tvshows/trending_tv_shows_cubit.dart' hide TrendingTvShowsCubit;

class TrendingTvShowsView extends StatelessWidget {
  const TrendingTvShowsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingTvShowsCubit()..fetchTrendingTvShows(),
      child: BlocBuilder<TrendingTvShowsCubit, TrendingTvShowsState>(
        builder: (context, state) {
          if (state is TrendingTvLoading) {
            return const MoviesCardShimmerListView();
          } else if (state is TrendingTvLoaded) {
            return TrendingMoviesListView(
              items: state.movies,
              contentType: 'tv',
            );
          } else if (state is TrendingTvFailed) {
            return Center(child: Text(state.errorMessage));
          }

          // Initial state (empty placeholder)
          return const MoviesCardShimmerListView();
        },
      ),
    );
  }
}
