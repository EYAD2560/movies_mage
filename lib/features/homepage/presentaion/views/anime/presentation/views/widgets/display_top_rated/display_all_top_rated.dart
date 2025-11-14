import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/pagination/cubit/global_paginator_cubit.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/features/homepage/presentaion/views/anime/presentation/views/widgets/all_anime_listview.dart';
import 'top_rated_service.dart';

class AllTopRatedAnimeListview extends StatelessWidget {
  const AllTopRatedAnimeListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GlobalPaginatorCubit<GlobalModel>(
        fetchPage: (page) =>
            TopRatedAnimeService().fetchTopRatedAnime(page: page),
      )..fetchNextPage(),
      child: const _AllTopRatedAnimeBody(),
    );
  }
}

class _AllTopRatedAnimeBody extends StatelessWidget {
  const _AllTopRatedAnimeBody();

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final cubit = context.read<GlobalPaginatorCubit<GlobalModel>>();

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
          const AllHeadLine(title: "Top Rated Anime"),
            const SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<GlobalPaginatorCubit<GlobalModel>, GlobalPaginatorState<GlobalModel>>(
                builder: (context, state) {
                  final isInitialLoading =
                          state is GlobalPaginationLoading<GlobalModel> &&
                          state.items.isEmpty;
                      final isPaginating =
                          state is GlobalPaginationLoading<GlobalModel> &&
                          state.items.isNotEmpty;
        
                      List<GlobalModel> items = [];
                      if (state is GlobalPaginationLoaded<GlobalModel> ||
                          state is GlobalPaginationLoading<GlobalModel> ||
                          state is GlobalPaginationError<GlobalModel>) {
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
