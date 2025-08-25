part of 'pagination_cupit.dart';

abstract class PopularAnimePaginationState<GlobalModel> {
  final List<GlobalModel> items;
  const PopularAnimePaginationState(this.items);
}

class PaginationInitial<GlobalModel> extends PopularAnimePaginationState<GlobalModel> {
  const PaginationInitial() : super(const []);
}

class PopularAnimePaginationLoading<GlobalModel> extends PopularAnimePaginationState<GlobalModel> {
  // ignore: use_super_parameters
  const PopularAnimePaginationLoading(List<GlobalModel> items) : super(items);
}

class PopularAnimePaginationLoaded<GlobalModel> extends PopularAnimePaginationState<GlobalModel> {
  final bool hasMore;
  // ignore: use_super_parameters
  const PopularAnimePaginationLoaded(List<GlobalModel> items, {required this.hasMore}) : super(items);
}

class PopularAnimePaginationError<GlobalModel> extends PopularAnimePaginationState<GlobalModel> {
  final String error;
  // ignore: use_super_parameters
  const PopularAnimePaginationError(List<GlobalModel> items, this.error) : super(items);
}
