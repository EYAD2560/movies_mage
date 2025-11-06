part of 'pagination_cupit.dart';

abstract class TopRatedPaginationState<GlobalModel> {
  final List<GlobalModel> items;
  const TopRatedPaginationState(this.items);
}

class PaginationInitial<GlobalModel> extends TopRatedPaginationState<GlobalModel> {
  const PaginationInitial() : super(const []);
}

class PaginationLoading<GlobalModel> extends TopRatedPaginationState<GlobalModel> {
  // ignore: use_super_parameters
  const PaginationLoading(List<GlobalModel> items) : super(items);
}

class PaginationLoaded<GlobalModel> extends TopRatedPaginationState<GlobalModel> {
  final bool hasMore;
  // ignore: use_super_parameters
  const PaginationLoaded(List<GlobalModel> items, {required this.hasMore}) : super(items);
}

class PaginationError<GlobalModel> extends TopRatedPaginationState<GlobalModel> {
  final String error;
  // ignore: use_super_parameters
  const PaginationError(List<GlobalModel> items, this.error) : super(items);
}
