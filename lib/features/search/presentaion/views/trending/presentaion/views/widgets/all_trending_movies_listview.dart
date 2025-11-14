// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/pagination/cubit/global_paginator_cubit.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/features/homepage/presentaion/views/movies/presentation/views/widgets/all_movies_list_view.dart';
import 'package:movies_mage/features/search/presentaion/views/widgets/sevices/search_service.dart';

class AllTrendingMoviesListview extends StatelessWidget {
  const AllTrendingMoviesListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GlobalPaginatorCubit<GlobalModel>(
        fetchPage: (int page) async {
          final service = SearchService();
          return await service.fetchTrendingMovies(page: page);
        },
      )..fetchNextPage(),
      child: const _TrendingMoviesBody(),
    );
  }
}

class _TrendingMoviesBody extends StatelessWidget {
  const _TrendingMoviesBody();

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
            const AllHeadLine(title: "Trending Movies"),
            Expanded(
              child: BlocBuilder<GlobalPaginatorCubit<GlobalModel>,
                  GlobalPaginatorState<GlobalModel>>(
                builder: (context, state) {
                  final isInitialLoading =
                      state is GlobalPaginationLoading<GlobalModel> &&
                          state.items.isEmpty;
                  final isPaginating =
                      state is GlobalPaginationLoading<GlobalModel> &&
                          state.items.isNotEmpty;

                  List<GlobalModel> shows = const [];

                  if (state is GlobalPaginationLoaded<GlobalModel> ||
                      state is GlobalPaginationLoading<GlobalModel> ||
                      state is GlobalPaginationError<GlobalModel>) {
                    shows = state.items;
                  }

                  if (isInitialLoading) {
                    return const AllMoviessCardShimmerListView();
                  }

                  return AllMoviesListView(
                    scrollController: scrollController,
                    items: shows,
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
