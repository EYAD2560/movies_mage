import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/screens/movies/display_top_rated/cubit/top_rated_cubit.dart';
import 'package:movies_mage/widgets/listviews/movies_listview.dart';
import 'package:movies_mage/widgets/listviews/movies_shimmer_listview.dart';

class TopRatedListview extends StatelessWidget {
  const TopRatedListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopRatedCubit()..fetchTopRatedMovies(),
      child: BlocBuilder<TopRatedCubit, TopRatedState>(
        builder: (context, state) {
          if (state is TopRatedLoading) {
            return const MoviesCardShimmerListView();
          } else if (state is TopRatedLoaded) {
            return MoviesListView(
              items: state.movies,
              contentType: 'movie',
            );
          } else if (state is TopRatedFailed) {
            return Center(
              child: Text(
                state.errorMessage,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
