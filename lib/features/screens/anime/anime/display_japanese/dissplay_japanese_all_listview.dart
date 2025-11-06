import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/features/screens/anime/anime/display_japanese/cubit/pagination/pagination_cupit.dart';
import 'package:movies_mage/features/screens/anime/anime/all_anime_listview.dart';
import 'package:movies_mage/features/screens/anime/anime/display_japanese/dissplay_japanese_service.dart';
import 'package:movies_mage/core/global_model.dart';

class DisplayAlljapaneseAnimeListview extends StatelessWidget {
  const DisplayAlljapaneseAnimeListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => JapaneseAnimePagination<GlobalModel>(
        fetchPage: (page) =>
            DisplayAlljapaneseAnimeService().fetchAllJapaneseAnime(page: page),
      )..fetchNextPage(),
      child: const _DisplayAllJapaneseAnimeBody(),
    );
  }
}

class _DisplayAllJapaneseAnimeBody extends StatelessWidget {
  const _DisplayAllJapaneseAnimeBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<JapaneseAnimePagination<GlobalModel>>();
    final scrollController = ScrollController();

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
            const AllHeadLine(title: "Japanese Anime"),
            Expanded(
              child: BlocBuilder<JapaneseAnimePagination<GlobalModel>,
                  JapaneseAnimePaginationState<GlobalModel>>(
                builder: (context, state) {
                  final isInitialLoading =
                      state is JapaneseAnimePaginationLoading<GlobalModel> &&
                          state.items.isEmpty;
                  final isPaginating =
                      state is JapaneseAnimePaginationLoading<GlobalModel> &&
                          state.items.isNotEmpty;

                  List<GlobalModel> items = [];
                  if (state is JapaneseAnimePaginationLoaded<GlobalModel> ||
                      state is JapaneseAnimePaginationLoading<GlobalModel> ||
                      state is JapaneseAnimePaginationError<GlobalModel>) {
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
