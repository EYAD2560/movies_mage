// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/carsour/carsour_slider.dart';
import 'package:movies_mage/core/widgets/custom_bar.dart';
import 'package:movies_mage/core/widgets/shimmer/home_shimmer.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/anime/presentation/manger/upcomming_anime/upcomming_anime_cubit.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/anime/presentation/views/widgets/display_english/display_japanese/dissplay_english_all_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/anime/presentation/views/widgets/display_english/display_japanese/dissplay_english_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/anime/presentation/views/widgets/display_japanese/dissplay_japanese_all_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/anime/presentation/views/widgets/display_japanese/dissplay_japanese_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/anime/presentation/views/widgets/display_popular/diaplay_all_now_playing.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/anime/presentation/views/widgets/display_popular/now_playing_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/anime/presentation/views/widgets/display_top_rated/display_all_top_rated.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/anime/presentation/views/widgets/display_top_rated/top_rated_listview.dart';


class AnimeBody extends StatelessWidget {
  const AnimeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UpcommingAnimeCubit, AnimeStates>(
      builder: (context, state) {
        // Trigger the fetch only once
        if (state is AnimeInitial) {
          Future.microtask(
              () => context.read<UpcommingAnimeCubit>().showAnime());
          return const HomeShimmerScreen();
        }

        if (state is AnimeLoading) {
          return const HomeShimmerScreen();
        }

        if (state is AnimeLoaded) {
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
                              builder: (context) =>
                                  const AllTopRatedAnimeListview(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const TopRatedAnimeListview(),
                      const SizedBox(height: 20),
                      Custombar(
                        title: 'Popular',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AllNowPlayingAnimeListview(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const NowPlayingAnimeListview(),
                      const SizedBox(height: 10),
                      Custombar(
                        title: 'Japanese Anime',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DisplayAlljapaneseAnimeListview(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const JapaneseAnimeListview(),
                      const SizedBox(height: 10),
                      Custombar(
                        title: 'English Anime',
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const DisplayAllEnglishAnimeListview(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      const EnglishAnimeListview(),
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
