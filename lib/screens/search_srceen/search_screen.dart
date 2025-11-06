


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/custom_tapbar.dart';
import 'package:movies_mage/core/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/screens/search_srceen/cubit/search_cubit.dart';
import 'package:movies_mage/screens/search_srceen/widgets/build_content.dart/search_results.dart';
import 'package:movies_mage/screens/search_srceen/widgets/build_content.dart/trending_content.dart';
import 'package:movies_mage/screens/search_srceen/widgets/search_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SearchCubit(),
      child: const _SearchView(),
    );
  }
}

class _SearchView extends StatelessWidget {
  const _SearchView();

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            context.read<SearchCubit>().reset();
            controller.clear();
          },
          child: Scaffold(
            backgroundColor: Colors.black,
            body: BlocBuilder<SearchCubit, SearchState>(
              builder: (context, state) {
                return Column(
                  children: [
                    // ---------- HEADER ----------
                    const AllHeadLine(title: 'Search'),

                    // ---------- SEARCH BAR ----------
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: CustomSearchBar(
                        controller: controller,
                        onSearchChanged: (query) {
                          if (query.isEmpty) {
                            context.read<SearchCubit>().reset();
                          } else {
                            context.read<SearchCubit>().search(query);
                          }
                        },
                      ),
                    ),

                    const SizedBox(height: 20),

                    // ---------- BODY ----------
                    if (state is SearchInitial) ...[
                      Expanded(child: Trendingcontent(context: context)),
                    ] else if (state is SearchLoading) ...[
                      const Expanded(
                        child: AllMoviessCardShimmerListView(),
                      ),
                    ] else if (state is SearchLoaded) ...[
                      const CustomTabBar(
                        tabTitles: ['Movies', 'TV Shows'],
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: SearchResults(
                          movies: state.results
                              .where((item) => item.mediaType == 'movie')
                              .toList(),
                          tvShows: state.results
                              .where((item) => item.mediaType == 'tv')
                              .toList(),
                        ),
                      ),
                    ] else if (state is SearchError) ...[
                      Expanded(
                        child: Center(
                          child: Text(
                            state.message,
                            style: const TextStyle(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
