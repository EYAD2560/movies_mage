import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/screens/search_srceen/trending/movies/trending_movies_cubit.dart';
import 'package:movies_mage/screens/search_srceen/trending/trending_listview.dart';
import 'package:movies_mage/widgets/listviews/movies_shimmer_listview.dart';

class TrendingMoviesView extends StatelessWidget {
  const TrendingMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TrendingMoviesCubit()..fetchTrendingMovies(),
      child: BlocBuilder<TrendingMoviesCubit, TrendingMoviesState>(
        builder: (context, state) {
          if (state is TrendingMoviesLoading) {
            return const MoviesCardShimmerListView();
          } else if (state is TrendingMoviesLoaded) {
            return TrendingMoviesListView(
              items: state.movies,
              contentType: 'movie',
            );
          } else if (state is TrendingMoviesFailed) {
            return Center(child: Text(state.errorMessage));
          }

          // Initial state (empty placeholder)
          return const MoviesCardShimmerListView();
        },
      ),
    );
  }
}
