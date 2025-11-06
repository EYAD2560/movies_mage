import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/features/screens/tv_shows/presentation/manger/all_tv_cubits/pagination/pagination_cubit.dart';
import 'package:movies_mage/features/screens/tv_shows/presentation/views/widgets/all_tv_listview.dart';
import 'package:movies_mage/screens/tv_shows/presentation/views/widgets/display_all/diaplay_all_service.dart';
import 'package:movies_mage/core/global_model.dart';

class DisplayAllShowsListview extends StatelessWidget {
  final ScrollController controller;
  const DisplayAllShowsListview({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AllTvPaginationCubit<GlobalModel>(
        fetchPage: (page) => DisplayAllShowsService().fetchAllShows(page: page),
      )..fetchNextPage(),
      child: _DisplayAllShowsView(scrollcontroller: controller),
    );
  }
}

class _DisplayAllShowsView extends StatelessWidget {
  final ScrollController scrollcontroller;
  const _DisplayAllShowsView({required this.scrollcontroller});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AllTvPaginationCubit<GlobalModel>>();

    scrollcontroller.addListener(() {
      if (scrollcontroller.position.pixels >=
              scrollcontroller.position.maxScrollExtent - 300 &&
          cubit.hasMore &&
          cubit.state is! AllTvPaginationLoading) {
        cubit.fetchNextPage();
      }
    });

    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const AllHeadLine(title: "All Shows"),
            Expanded(
              child:
                  BlocBuilder<
                    AllTvPaginationCubit<GlobalModel>,
                    AllTvPaginationState<GlobalModel>
                  >(
                    builder: (context, state) {
                      final isInitialLoading =
                          state is AllTvPaginationLoading<GlobalModel> &&
                          state.items.isEmpty;
                      final isPaginating =
                          state is AllTvPaginationLoading<GlobalModel> &&
                          state.items.isNotEmpty;
        
                      List<GlobalModel> items = [];
                      if (state is AllTvPaginationLoaded<GlobalModel> ||
                          state is AllTvPaginationLoading<GlobalModel> ||
                          state is AllTvPaginationError<GlobalModel>) {
                        items = state.items;
                      }
        
                      if (isInitialLoading) {
                        return const AllMoviessCardShimmerListView();
                      }
        
                      return AllTvListView(
                        scrollController: scrollcontroller,
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
