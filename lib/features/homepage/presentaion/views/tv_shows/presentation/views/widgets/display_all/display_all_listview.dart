import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/listviews/movies_listview.dart';
import 'package:movies_mage/core/widgets/listviews/movies_shimmer_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/tv_shows/presentation/manger/all_tv_cubits/all_tv_cubit_cubit.dart';


class ShowsListview extends StatelessWidget {
  const ShowsListview({super.key});

  @override
  Widget build(BuildContext context) {

    return BlocProvider(
      create: (context) => AllTvCubit()..fetchAllShows(),
      child: BlocBuilder<AllTvCubit, AllTvCubitState>(
        builder: (context, state) {
          if (state is AllTVLoading) {
            return const MoviesCardShimmerListView();
          } else if (state is AllTVLoaded) {
            return MoviesListView(
              items: state.shows,
              contentType: 'tv',
            );
          } else if (state is AllTVFailed) {
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
