import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/screens/movies/display_top_rated/cubit/cupits/pagination/pagination_cupit.dart';
import 'package:movies_mage/widgets/all_head_line.dart';
import 'package:movies_mage/screens/movies/all_movies_list_view.dart';
import 'package:movies_mage/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'top_rated_service.dart';

class AllTopRatedListview extends StatelessWidget {
  const AllTopRatedListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopRatedPagination<GlobalModel>(
        fetchPage: (page) => TopRatedService().fetchTopRatedMovies(page: page),
      )..fetchNextPage(),
      child: const _AllTopRatedBody(),
    );
  }
}

class _AllTopRatedBody extends StatelessWidget {
  const _AllTopRatedBody();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TopRatedPagination<GlobalModel>>();
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
            const AllHeadLine(title: 'Top Rated Movies'),
            Expanded(
              child: BlocBuilder<TopRatedPagination<GlobalModel>,
                  TopRatedPaginationState<GlobalModel>>(
                builder: (context, state) {
                  final items = state.items;

                  final isInitialLoading =
                      state is PaginationLoading<GlobalModel> && items.isEmpty;
                  final isPaginating =
                      state is PaginationLoading<GlobalModel> &&
                          items.isNotEmpty;

                  if (isInitialLoading) {
                    return const AllMoviessCardShimmerListView();
                  }

                  return AllMoviesListView(
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
