import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/screens/tv_shows/display_top_rated/cubit/pagination/pagination_cubit.dart';
import 'package:movies_mage/widgets/all_head_line.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/screens/tv_shows/all_tv_listview.dart';
import 'top_rated_service.dart';

class AllTopRatedShowsListview extends StatelessWidget {
  const AllTopRatedShowsListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TopRatedTvPaginationCubit<GlobalModel>(
        fetchPage: (int page) async {
          final service = TopRatedTvShowsService();
          return await service.fetchTopRatedTvShows(page: page);
        },
      )..fetchNextPage(),
      child: const _TopRatedShowsBody(),
    );
  }
}

class _TopRatedShowsBody extends StatelessWidget {
  const _TopRatedShowsBody();

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final cubit = context.read<TopRatedTvPaginationCubit<GlobalModel>>();

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
          const AllHeadLine(title: "Top Rated Shows"),
            Expanded(
              child:
                  BlocBuilder<
                    TopRatedTvPaginationCubit<GlobalModel>,
                    TopRatedTvPaginationState<GlobalModel>
                  >(
                    builder: (context, state) {
                      final isInitialLoading =
                          state is TopRatedTvPaginationLoading<GlobalModel> &&
                          state.items.isEmpty;
                      final isPaginating =
                          state is TopRatedTvPaginationLoading<GlobalModel> &&
                          state.items.isNotEmpty;
        
                      List<GlobalModel> shows = [];
        
                      if (state is TopRatedPaginationLoaded<GlobalModel> ||
                          state is TopRatedTvPaginationLoading<GlobalModel> ||
                          state is TopRatedTvPaginationError<GlobalModel>) {
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
