import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/screens/search_srceen/sevices/search_service.dart';
import 'package:movies_mage/screens/search_srceen/trending/tvshows/pagination/pagination_cubit.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/screens/tv_shows/presentation/views/widgets/all_tv_listview.dart';

class AllTrendingTvShowsListview extends StatelessWidget {
  const AllTrendingTvShowsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrendaingTvPaginationCubit<GlobalModel>(
        fetchPage: (int page) async {
          final service = SearchService();
          return await service.fetchTrendingTvShows(page: page);
        },
      )..fetchNextPage(),
      child: const _TrendingTvShowsBody(),
    );
  }
}

class _TrendingTvShowsBody extends StatelessWidget {
  const _TrendingTvShowsBody();

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final cubit = context.read<TrendaingTvPaginationCubit<GlobalModel>>();

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
           const AllHeadLine(title: "Trending Tv Shows"),
            Expanded(
              child:
                  BlocBuilder<
                    TrendaingTvPaginationCubit<GlobalModel>,
                    TrendaingTvPaginationState<GlobalModel>
                  >(
                    builder: (context, state) {
                      final isInitialLoading =
                          state is TrendaingTvPaginationLoading<GlobalModel> &&
                          state.items.isEmpty;
                      final isPaginating =
                          state is TrendaingTvPaginationLoading<GlobalModel> &&
                          state.items.isNotEmpty;
        
                      List<GlobalModel> shows = [];
        
                      if (state is TrendaingTvPaginationLoaded<GlobalModel> ||
                          state is TrendaingTvPaginationLoading<GlobalModel> ||
                          state is TrendaingTvPaginationError<GlobalModel>) {
                        shows = state.items;
                      }
        
                      if (isInitialLoading) {
                        return const AllMoviessCardShimmerListView();
                      }
        
                      return AllTvListView(
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
