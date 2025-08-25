part of 'pagination_cupit.dart';

abstract class AllPaginationState<GlobalModel> {
  final List<GlobalModel> items;
  const AllPaginationState(this.items);
}

class PaginationInitial<GlobalModel> extends AllPaginationState<GlobalModel> {
  const PaginationInitial() : super(const []);
}

class PaginationLoading<GlobalModel> extends AllPaginationState<GlobalModel> {
  // ignore: use_super_parameters
  const PaginationLoading(List<GlobalModel> items) : super(items);
}

class PaginationLoaded<GlobalModel> extends AllPaginationState<GlobalModel> {
  final bool hasMore;
  // ignore: use_super_parameters
  const PaginationLoaded(List<GlobalModel> items, {required this.hasMore}) : super(items);
}

class PaginationError<GlobalModel> extends AllPaginationState<GlobalModel> {
  final String error;
  // ignore: use_super_parameters
  const PaginationError(List<GlobalModel> items, this.error) : super(items);
}
