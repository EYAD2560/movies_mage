part of 'pagination_cupit.dart';

abstract class NowPlayingPaginationState<GlobalModel> {
  final List<GlobalModel> items;
  const NowPlayingPaginationState(this.items);
}

class PaginationInitial<GlobalModel> extends NowPlayingPaginationState<GlobalModel> {
  const PaginationInitial() : super(const []);
}

class PaginationLoading<GlobalModel> extends NowPlayingPaginationState<GlobalModel> {
  // ignore: use_super_parameters
  const PaginationLoading(List<GlobalModel> items) : super(items);
}

class PaginationLoaded<GlobalModel> extends NowPlayingPaginationState<GlobalModel> {
  final bool hasMore;
  // ignore: use_super_parameters
  const PaginationLoaded(List<GlobalModel> items, {required this.hasMore}) : super(items);
}

class PaginationError<GlobalModel> extends NowPlayingPaginationState<GlobalModel> {
  final String error;
  // ignore: use_super_parameters
  const PaginationError(List<GlobalModel> items, this.error) : super(items);
}
