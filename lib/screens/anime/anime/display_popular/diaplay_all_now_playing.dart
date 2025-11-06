import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/screens/anime/anime/display_popular/cubit/pagination/pagination_cupit.dart';
import 'package:movies_mage/screens/anime/anime/all_anime_listview.dart';
import 'package:movies_mage/core/global_model.dart';
import 'now_playing_service.dart';

class AllNowPlayingAnimeListview extends StatelessWidget {
  const AllNowPlayingAnimeListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PopularAnimePagination<GlobalModel>(
        fetchPage: (page) =>
            NowPlayingAnimeService().fetchNowPlayingAnime(page: page),
      )..fetchNextPage(),
      child: const _AllNowPlayingAnimeBody(),
    );
  }
}

class _AllNowPlayingAnimeBody extends StatelessWidget {
  const _AllNowPlayingAnimeBody();

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final cubit = context.read<PopularAnimePagination<GlobalModel>>();

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent - 300 &&
          cubit.hasMore) {
        cubit.fetchNextPage();
      }
    });

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AllHeadLine(title: "Popular Anime"),
            Expanded(
              child: BlocBuilder<PopularAnimePagination<GlobalModel>,
                  PopularAnimePaginationState<GlobalModel>>(
                builder: (context, state) {
                  final isInitialLoading =
                      state is PopularAnimePaginationLoading<GlobalModel> &&
                          state.items.isEmpty;
                  final isPaginating =
                      state is PopularAnimePaginationLoading<GlobalModel> &&
                          state.items.isNotEmpty;

                  List<GlobalModel> items = [];
                  if (state is PopularAnimePaginationLoaded<GlobalModel> ||
                      state is PopularAnimePaginationLoading<GlobalModel> ||
                      state is PopularAnimePaginationError<GlobalModel>) {
                    items = state.items;
                  }

                  if (isInitialLoading) {
                    return const AllMoviessCardShimmerListView();
                  }

                  return AllAnimeListView(
                    scrollController: scrollController,
                    items: items,
                    showShimmer: isPaginating,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
