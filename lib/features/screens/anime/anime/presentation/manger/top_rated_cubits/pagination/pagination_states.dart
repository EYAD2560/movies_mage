part of 'pagination_cupit.dart';

abstract class TopRatedAnimePaginationPaginationState<GlobalModel> {
  final List<GlobalModel> items;
  const TopRatedAnimePaginationPaginationState(this.items);
}

class PaginationInitial<GlobalModel> extends TopRatedAnimePaginationPaginationState<GlobalModel> {
  const PaginationInitial() : super(const []);
}

class TopRatedAnimePaginationLoading<GlobalModel> extends TopRatedAnimePaginationPaginationState<GlobalModel> {
  // ignore: use_super_parameters
  const TopRatedAnimePaginationLoading(List<GlobalModel> items) : super(items);
}

class TopRatedAnimePaginationLoaded<GlobalModel> extends TopRatedAnimePaginationPaginationState<GlobalModel> {
  final bool hasMore;
  // ignore: use_super_parameters
  const TopRatedAnimePaginationLoaded(List<GlobalModel> items, {required this.hasMore}) : super(items);
}

class TopRatedAnimePaginationError<GlobalModel> extends TopRatedAnimePaginationPaginationState<GlobalModel> {
  final String error;
  // ignore: use_super_parameters
  const TopRatedAnimePaginationError(List<GlobalModel> items, this.error) : super(items);
}
