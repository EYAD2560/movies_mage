import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/listviews/movies_listview.dart';
import 'package:movies_mage/core/widgets/listviews/movies_shimmer_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/movies/presentation/maneger/now_playing_cupits/nowplaying_cubit.dart';


class NowPlayingListview extends StatelessWidget {
  const NowPlayingListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NowplayingCubit()..fetchNowPlayingMovies(),
      child: BlocBuilder<NowplayingCubit, NowplayingState>(
        builder: (context, state) {
          if (state is NowPlayingLoading) {
            return const MoviesCardShimmerListView();
          } else if (state is NowPlayingLoaded) {
            return MoviesListView(
              items: state.movies,
              contentType: 'movie',
            );
          } else if (state is NowPlayingFailed) {
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
