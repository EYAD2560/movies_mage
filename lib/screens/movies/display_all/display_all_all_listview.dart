import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/listviews/all_movies_card_shimmer_listview.dart';
import 'package:movies_mage/screens/movies/display_all/cubit/pagination/pagination_cupit.dart';
import 'package:movies_mage/screens/movies/display_all/diaplay_all_service.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/screens/movies/presentation/views/widgets/all_movies_list_view.dart';

class DisplayAllMoviesListview extends StatelessWidget {
  const DisplayAllMoviesListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AllPagination<GlobalModel>(
        fetchPage: (page) => DisplayAllService().fetchAllMovies(page: page),
      )..fetchNextPage(),
      child: const _DisplayAllMoviesBody(),
    );
  }
}

class _DisplayAllMoviesBody extends StatelessWidget {
  const _DisplayAllMoviesBody();

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final cubit = context.read<AllPagination<GlobalModel>>();

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
            const AllHeadLine(title: "All movies"),
            Expanded(
              child: BlocBuilder<AllPagination<GlobalModel>,
                  AllPaginationState<GlobalModel>>(
                builder: (context, state) {
                  // ignore: unused_local_variable
                  final cubit = context.read<AllPagination<GlobalModel>>();
                  List<GlobalModel> items = [];

                  final isInitialLoading =
                      state is PaginationLoading<GlobalModel> &&
                          state.items.isEmpty;
                  final isPaginating =
                      state is PaginationLoading<GlobalModel> &&
                          state.items.isNotEmpty;

                  if (state is PaginationLoaded<GlobalModel> ||
                      state is PaginationLoading<GlobalModel> ||
                      state is PaginationError<GlobalModel>) {
                    items = state.items;
                  }

                  if (isInitialLoading) {
                    return const AllMoviessCardShimmerListView(); // Full shimmer screen
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
