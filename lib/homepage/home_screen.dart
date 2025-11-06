import 'package:flutter/material.dart';
import 'package:movies_mage/core/widgets/custom_appbar.dart';
import 'package:movies_mage/core/widgets/custom_tapbar.dart';
import 'package:movies_mage/screens/anime/anime/anime_view.dart';
import 'package:movies_mage/screens/movies/presentation/views/movies_page_view.dart';
import 'package:movies_mage/screens/tv_shows/tv_shows_view.dart';


class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});
  final List<String> tabs = ["Movies", "Tv Shows", "Anime"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: tabs.length,
        child: Stack(
          children: [
            const TabBarView(
              physics: BouncingScrollPhysics(),
              children: [MoviespageView(),TvShowsView(), AnimeView()],
            ),
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: CustomAppbar(),
            ),
            const CustomTabBar(
              tabTitles: ["Movies", "Tv Shows", "Anime"],
            ), // ✅ Cleaner
          ],
        ),
      ),
    );
  }
}
