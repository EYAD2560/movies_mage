part of 'pagination_cubit.dart';

/// Base state for pagination
sealed class TopRatedTvPaginationState<GlobalModel> extends Equatable {
  final List<GlobalModel> items;

  const TopRatedTvPaginationState(this.items);

  @override
  List<Object?> get props => [items];
}

final class PaginationInitial<T> extends TopRatedTvPaginationState<T> {
  const PaginationInitial() : super(const []);
}

final class TopRatedTvPaginationLoading<T> extends TopRatedTvPaginationState<T> {
  // ignore: use_super_parameters
  const TopRatedTvPaginationLoading(List<T> items) : super(items);
}

final class TopRatedPaginationLoaded<T> extends TopRatedTvPaginationState<T> {
  final bool hasMore;

  // ignore: use_super_parameters
  const TopRatedPaginationLoaded(List<T> items, {required this.hasMore})
      : super(items);

  @override
  List<Object?> get props => [items, hasMore];
}

final class TopRatedTvPaginationError<T> extends TopRatedTvPaginationState<T> {
  final String error;

  // ignore: use_super_parameters
  const TopRatedTvPaginationError(List<T> items, this.error) : super(items);

  @override
  List<Object?> get props => [items, error];
}
