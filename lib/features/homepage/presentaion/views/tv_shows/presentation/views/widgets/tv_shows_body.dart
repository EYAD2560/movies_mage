// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/carsour/carsour_slider.dart';
import 'package:movies_mage/core/widgets/custom_bar.dart';
import 'package:movies_mage/core/widgets/shimmer/home_shimmer.dart';
import 'package:movies_mage/features/homepage/presentaion/views/tv_shows/presentation/views/widgets/display_all/display_all_all_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/tv_shows/presentation/views/widgets/display_all/display_all_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/tv_shows/presentation/views/widgets/display_now_playing/diaplay_all_now_playing.dart';
import 'package:movies_mage/features/homepage/presentaion/views/tv_shows/presentation/views/widgets/display_now_playing/now_playing_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/tv_shows/presentation/views/widgets/display_top_rated/display_all_top_rated.dart';
import 'package:movies_mage/features/homepage/presentaion/views/tv_shows/presentation/views/widgets/display_top_rated/top_rated_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/tv_shows/presentation/manger/upcomming_tv.dart/upcoming_tvshows_cubit.dart';


class TvShowsPageBody extends StatelessWidget {
  const TvShowsPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();

    return BlocBuilder<UpcomingTvshowsCubit, TvShowsStates>(
      builder: (context, state) {
        // Fetch once when first entering initial state
        if (state is TvShowsInitial) {
          Future.microtask(() => context.read<UpcomingTvshowsCubit>().showTvShows());
          return const HomeShimmerScreen();
        }

        if (state is TvShowsLoading) {
          return const HomeShimmerScreen();
        }

        if (state is TvShowsLoaded) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  child: state.posters.isNotEmpty
                      ? CarouseSlider(posters: state.posters)
                      : const Center(child: Text('No posters available')),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 64),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Custombar(
                        title: 'Top Rated',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AllTopRatedShowsListview(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const TopRatedShowsListview.TopRatedShowsListview(),
                      const SizedBox(height: 20),
                      Custombar(
                        title: 'Now Playing',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AllNowAiringListview(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const NowAiringListview(),
                      const SizedBox(height: 10),
                      Custombar(
                        title: 'All Shows',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DisplayAllShowsListview(controller: controller),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const ShowsListview(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        return const Center(child: Text('Something went wrong'));
      },
    );
  }
}
