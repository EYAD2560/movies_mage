import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/screens/tv_shows/display_top_rated/cubit/top_rated_tv_cubit.dart';
import 'package:movies_mage/widgets/listviews/movies_listview.dart';
import 'package:movies_mage/widgets/listviews/movies_shimmer_listview.dart';

class TopRatedShowsListview extends StatelessWidget {
  // ignore: non_constant_identifier_names
  const TopRatedShowsListview.TopRatedShowsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopRatedTvCubit()..fetchTopRatedTvShows(),
      child: BlocBuilder<TopRatedTvCubit, TopRatedTvState>(
        builder: (context, state) {
          if (state is TopRatedTVLoading) {
            return const MoviesCardShimmerListView();
          } else if (state is TopRatedTVLoaded) {
            return MoviesListView(
              items: state.shows,
              contentType: 'tv',
            );
          } else if (state is TopRatedTVFailed) {
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
