import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/anime/presentation/views/widgets/all_anime_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/anime/presentation/views/widgets/display_english/display_japanese/dissplay_english_service.dart';

class DisplayAllEnglishAnimeListview extends StatelessWidget {
  const DisplayAllEnglishAnimeListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EnglishAnimePagination<GlobalModel>(
        fetchPage: (page) =>
            DisplayAllenglishAnimeService().fetchAllenglishAnime(page: page),
      )..fetchNextPage(),
      child: const _DisplayAllEnglishAnimeBody(),
    );
  }
}

class _DisplayAllEnglishAnimeBody extends StatelessWidget {
  const _DisplayAllEnglishAnimeBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<EnglishAnimePagination<GlobalModel>>();
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
          const AllHeadLine(title: "English Animation"),
            Expanded(
              child: BlocBuilder<
                  EnglishAnimePagination<GlobalModel>,
                  EnglishAnimePaginationState<GlobalModel>>(
                builder: (context, state) {
                   final isInitialLoading =
                          state is EnglishAnimePaginationLoading<GlobalModel> &&
                          state.items.isEmpty;
                      final isPaginating =
                          state is EnglishAnimePaginationLoading<GlobalModel> &&
                          state.items.isNotEmpty;
        
                      List<GlobalModel> items = [];
                      if (state is EnglishAnimePaginationLoaded<GlobalModel> ||
                          state is EnglishAnimePaginationLoading<GlobalModel> ||
                          state is EnglishAnimePaginationError<GlobalModel>) {
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
