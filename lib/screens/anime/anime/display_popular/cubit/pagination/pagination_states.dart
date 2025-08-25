part of 'pagination_cupit.dart';

abstract class popularAnimePaginationState<GlobalModel> {
  final List<GlobalModel> items;
  const popularAnimePaginationState(this.items);
}

class PaginationInitial<GlobalModel> extends popularAnimePaginationState<GlobalModel> {
  const PaginationInitial() : super(const []);
}

class PopularAnimePaginationLoading<GlobalModel> extends popularAnimePaginationState<GlobalModel> {
  // ignore: use_super_parameters
  const PopularAnimePaginationLoading(List<GlobalModel> items) : super(items);
}

class PopularAnimePaginationLoaded<GlobalModel> extends popularAnimePaginationState<GlobalModel> {
  final bool hasMore;
  // ignore: use_super_parameters
  const PopularAnimePaginationLoaded(List<GlobalModel> items, {required this.hasMore}) : super(items);
}

class PopularAnimePaginationError<GlobalModel> extends popularAnimePaginationState<GlobalModel> {
  final String error;
  // ignore: use_super_parameters
  const PopularAnimePaginationError(List<GlobalModel> items, this.error) : super(items);
}
