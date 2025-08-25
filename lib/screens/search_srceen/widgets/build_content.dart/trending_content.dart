import 'package:flutter/material.dart';
import 'package:movies_mage/screens/search_srceen/trending/all_trending_movies_listView.dart';
import 'package:movies_mage/screens/search_srceen/trending/all_trending_tv_listview.dart';
import 'package:movies_mage/screens/search_srceen/trending/trending_movies_ListView.dart';
import 'package:movies_mage/screens/search_srceen/trending/trending_tv_listiew.dart';
import 'package:movies_mage/screens/search_srceen/category_search/search_chips_listview.dart';
import 'package:movies_mage/screens/search_srceen/widgets/trending_bar.dart';

class Trendingcontent extends StatelessWidget {
  const Trendingcontent({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SearchChipsListView(),
          const SizedBox(height: 25),
          Trendingbar(
            title: "Trending Movies",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllTrendingMoviesListview(),
                ),
              );
            },
          ),
          const TrendingMoviesView(),
          const SizedBox(height: 25),
          Trendingbar(
            title: "Trending TV Shows",
            ontap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AllTrendingTvShowsListview(),
                ),
              );
            },
          ),
          const TrendingTvShowsView(),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
