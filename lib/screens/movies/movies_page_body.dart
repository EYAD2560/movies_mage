import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/screens/movies/Upcoming_movies/upcomming_movies_cubit.dart';
import 'package:movies_mage/screens/movies/display_all/display_all_all_listview.dart';
import 'package:movies_mage/screens/movies/display_all/display_all_listview.dart';
import 'package:movies_mage/screens/movies/display_now_playing/diaplay_all_now_playing.dart';
import 'package:movies_mage/screens/movies/display_now_playing/now_playing_listview.dart';
import 'package:movies_mage/screens/movies/display_top_rated/display_all_top_rated.dart';
import 'package:movies_mage/screens/movies/display_top_rated/top_rated_listview.dart';
import 'package:movies_mage/widgets/carsour/carsour_slider.dart';
import 'package:movies_mage/widgets/custom_bar.dart';
import 'package:movies_mage/shimmer/home_shimmer.dart';

class MoviesPagebody extends StatelessWidget {
  const MoviesPagebody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MoviesCubit, UpcommingMoviesStates>(
      builder: (context, state) {
        
        // Show shimmer while loading
        if (state is MoviesLoading) {
          return const HomeShimmerScreen();
        }

        // Show main UI when loaded
        if (state is MoviesLoaded) {
          if (state.posters.isEmpty) {
            return const Center(child: Text('No posters available'));
          }

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
              SizedBox(
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: double.infinity,
                  child: CarouseSlider(posters: state.posters),
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
                              builder: (context) =>
                                  const AllTopRatedListview(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const TopRatedListview(),
                      const SizedBox(height: 20),
                      Custombar(
                        title: 'Now Playing',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DisplayAllNowPlayingMoviesListview(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const NowPlayingListview(),
                      const SizedBox(height: 10),
                      Custombar(
                        title: 'All Movies',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DisplayAllMoviesListview(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const MoviesListview(),
                    ],
                  ),
                ),
              ],
            ),
          );
        }

        // Default fallback for unknown states
        return const Center(child: Text('Something went wrong'));
      },
    );
  }
}
