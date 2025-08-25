import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/screens/search_srceen/category_search/pagination/pagination_cubit.dart';
import 'package:movies_mage/screens/search_srceen/sevices/search_service.dart';
import 'package:movies_mage/widgets/all_head_line.dart';
import 'package:movies_mage/screens/search_srceen/category_search/grid_movies_card.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/screens/search_srceen/category_search/grid_view_shimmmer_listview.dart';
import 'package:movies_mage/shimmer/grid_view_shimmer.dart';

class TvCategorySearchListview extends StatelessWidget {
  final String categoryName;
  final int categoryId;

  const TvCategorySearchListview({
    super.key,
    required this.categoryName,
    required this.categoryId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CategorySearchPaginationCubit<GlobalModel>(
        fetchPage: (int page) =>
            SearchService().fetchTvCategory(page: page, categoryId: categoryId),
      )..fetchNextPage(),
      child: TvCategorySearchListviewBody(title: categoryName),
    );
  }
}

class TvCategorySearchListviewBody extends StatelessWidget {
  final String title;

  const TvCategorySearchListviewBody({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final cubit = context.read<CategorySearchPaginationCubit<GlobalModel>>();

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
            AllHeadLine(title: "$title Tv Shows"),
            const SizedBox(height: 12),
            Expanded(
              child: BlocBuilder<CategorySearchPaginationCubit<GlobalModel>,
                  CategorySearchPaginationState<GlobalModel>>(
                builder: (context, state) {
                  final isInitialLoading =
                      state is CategorySearchPaginationLoading<GlobalModel> &&
                          state.items.isEmpty;
                  final isPaginating =
                      state is CategorySearchPaginationLoading<GlobalModel> &&
                          state.items.isNotEmpty;

                  List<GlobalModel> movies = [];

                  if (state is CategorySearchPaginationLoaded<GlobalModel> ||
                      state is CategorySearchPaginationLoading<GlobalModel> ||
                      state is CategorySearchPaginationError<GlobalModel>) {
                    movies = state.items;
                  }

                  if (isInitialLoading) {
                    return const GridMoviesCardShimmerListview(); // initial shimmer
                  }

                  return GridView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(12),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 0.55,
                    ),
                    itemCount: isPaginating ? movies.length + 6 : movies.length,
                    itemBuilder: (context, index) {
                      if (index >= movies.length) {
                        return const GridMoviesCardShimmer(); // pagination shimmer
                      }

                      final movie = movies[index];
                      return GridMoviesCard(
                        poster: movie.poster,
                        name: movie.name,
                        rate: movie.rate,
                        contenttype: 'tv',
                        movieId: movie.id,
                      );
                    },
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
