part of 'pagination_cubit.dart';

/// Base state for pagination
sealed class NowPlayingTvPaginationState<GlobalModel> extends Equatable {
  final List<GlobalModel> items;

  const NowPlayingTvPaginationState(this.items);

  @override
  List<Object?> get props => [items];
}

final class PaginationInitial<T> extends NowPlayingTvPaginationState<T> {
  const PaginationInitial() : super(const []);
}

final class NowPlayingTvPaginationLoading<T> extends NowPlayingTvPaginationState<T> {
  // ignore: use_super_parameters
  const NowPlayingTvPaginationLoading(List<T> items) : super(items);
}

final class NowPlayingPaginationLoaded<T> extends NowPlayingTvPaginationState<T> {
  final bool hasMore;

  // ignore: use_super_parameters
  const NowPlayingPaginationLoaded(List<T> items, {required this.hasMore})
      : super(items);

  @override
  List<Object?> get props => [items, hasMore];
}

final class NowPlayingTvPaginationError<T> extends NowPlayingTvPaginationState<T> {
  final String error;

  // ignore: use_super_parameters
  const NowPlayingTvPaginationError(List<T> items, this.error) : super(items);

  @override
  List<Object?> get props => [items, error];
}
