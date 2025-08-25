import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/screens/tv_shows/display_now_playing/cubit/now_playing_tv_cubit.dart';
import 'package:movies_mage/widgets/listviews/movies_listview.dart';
import 'package:movies_mage/widgets/listviews/movies_shimmer_listview.dart';

class NowAiringListview extends StatelessWidget {
  const NowAiringListview({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => NowPlayingTvCubit()..fetchAiringShows(),
      child: BlocBuilder<NowPlayingTvCubit, NowPlayingTvState>(
        builder: (context, state) {
          if (state is AiringTVLoading) {
            return const MoviesCardShimmerListView();
          } else if (state is AiringTVLoaded) {
            return MoviesListView(
              items: state.shows,
              contentType: 'tv',
            );
          } else if (state is AiringTVFailed) {
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
