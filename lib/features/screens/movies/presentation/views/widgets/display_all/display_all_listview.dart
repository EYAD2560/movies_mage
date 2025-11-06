import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/listviews/movies_listview.dart';
import 'package:movies_mage/core/widgets/listviews/movies_shimmer_listview.dart';
import 'package:movies_mage/features/screens/movies/presentation/maneger/all_movies_cupits/all_movies_cubit.dart';


class MoviesListview extends StatelessWidget {
  const MoviesListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllMoviesCubit()..fetchAllMovies(),
      child: BlocBuilder<AllMoviesCubit, AllMoviesState>(
        builder: (context, state) {
          if (state is AllMoviesLoading) {
            return const MoviesCardShimmerListView();
          } else if (state is AllMoviesLoaded) {
            return MoviesListView(
              items: state.movies,
              contentType: 'movie',
            );
          } else if (state is AllMoviesFailed) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          // Optional: fallback if state is not recognized
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
