import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/features/screens/anime/anime/presentation/manger/top_rated_cubits/pagination/pagination_cupit.dart';
import 'package:movies_mage/features/screens/anime/anime/presentation/views/widgets/all_anime_listview.dart';
import 'package:movies_mage/core/global_model.dart';
import 'top_rated_service.dart';

class AllTopRatedAnimeListview extends StatelessWidget {
  const AllTopRatedAnimeListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopRatedAnimePagination<GlobalModel>(
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
    final cubit = context.read<TopRatedAnimePagination<GlobalModel>>();

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
              child: BlocBuilder<TopRatedAnimePagination<GlobalModel>, TopRatedAnimePaginationPaginationState<GlobalModel>>(
                builder: (context, state) {
                  final isInitialLoading =
                          state is TopRatedAnimePaginationLoading<GlobalModel> &&
                          state.items.isEmpty;
                      final isPaginating =
                          state is TopRatedAnimePaginationLoading<GlobalModel> &&
                          state.items.isNotEmpty;
        
                      List<GlobalModel> items = [];
                      if (state is TopRatedAnimePaginationLoaded<GlobalModel> ||
                          state is TopRatedAnimePaginationLoading<GlobalModel> ||
                          state is TopRatedAnimePaginationError<GlobalModel>) {
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
