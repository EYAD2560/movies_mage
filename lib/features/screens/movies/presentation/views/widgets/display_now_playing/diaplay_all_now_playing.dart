
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/features/screens/movies/presentation/maneger/now_playing_cupits/pagination/pagination_cupit.dart';
import 'package:movies_mage/features/screens/movies/presentation/views/widgets/all_movies_list_view.dart';
import 'package:movies_mage/features/screens/movies/presentation/views/widgets/display_now_playing/now_playing_service.dart';

class DisplayAllNowPlayingMoviesListview extends StatelessWidget {
  const DisplayAllNowPlayingMoviesListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NowPlayingPagination<GlobalModel>(
        fetchPage: (page) =>
            NowPlayingService().fetchNowPlayingMovies(page: page),
      )..fetchNextPage(),
      child: const DisplayAllMoviesBody(),
    );
  }
}

class DisplayAllMoviesBody extends StatelessWidget {
  const DisplayAllMoviesBody({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final cubit = context.read<NowPlayingPagination<GlobalModel>>();
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
            const AllHeadLine(title: "Now Playing Movies"),
            Expanded(
              child: BlocBuilder<NowPlayingPagination<GlobalModel>,
                  NowPlayingPaginationState<GlobalModel>>(
                builder: (context, state) {
                  final isInitialLoading =
                      state is PaginationLoading<GlobalModel> &&
                          state.items.isEmpty;
                  final isPaginating =
                      state is PaginationLoading<GlobalModel> &&
                          state.items.isNotEmpty;

                  List<GlobalModel> items = [];
                  if (state is PaginationLoaded<GlobalModel> ||
                      state is PaginationLoading<GlobalModel> ||
                      state is PaginationError<GlobalModel>) {
                    items = state.items;
                  }

                  // ignore: unused_local_variable

                  if (isInitialLoading && items.isEmpty) {
                    // ✅ Show shimmer during initial loading
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
