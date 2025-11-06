import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/screens/tv_shows/presentation/manger/now_playing_cubits/pagination/pagination_cubit.dart';
import 'package:movies_mage/screens/tv_shows/presentation/views/widgets/display_now_playing/now_playing_service.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/screens/tv_shows/presentation/views/widgets/all_tv_listview.dart';

class AllNowAiringListview extends StatelessWidget {
  const AllNowAiringListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NowPlayingTvPaginationCubit<GlobalModel>(
        fetchPage: (page) => AiringService().fetchAiringShows(page: page),
      )..fetchNextPage(),
      child: const _NowAiringView(),
    );
  }
}

class _NowAiringView extends StatelessWidget {
  const _NowAiringView();

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final cubit = context.read<NowPlayingTvPaginationCubit<GlobalModel>>();

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
           const AllHeadLine(title: "Now Playing Shows"),
            Expanded(
              child: BlocBuilder<NowPlayingTvPaginationCubit<GlobalModel>, NowPlayingTvPaginationState<GlobalModel>>(
                builder: (context, state) {
                  final isInitialLoading =
                      state is NowPlayingTvPaginationLoading<GlobalModel> && state.items.isEmpty;
                  final isPaginating =
                      state is NowPlayingTvPaginationLoading<GlobalModel> && state.items.isNotEmpty;
        
                  List<GlobalModel> items = [];
                  if (state is NowPlayingPaginationLoaded<GlobalModel> ||
                      state is NowPlayingTvPaginationLoading<GlobalModel> ||
                      state is NowPlayingTvPaginationError<GlobalModel>) {
                    items = state.items;
                  }
        
                  if (isInitialLoading) {
                    return const AllMoviessCardShimmerListView() ;
                  }
        
                  return AllTvListView(
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
