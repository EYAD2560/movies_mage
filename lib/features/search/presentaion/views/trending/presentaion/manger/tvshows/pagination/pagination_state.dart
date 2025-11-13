part of 'pagination_cubit.dart';

/// Base state for pagination
sealed class TrendaingTvPaginationState<GlobalModel> extends Equatable {
  final List<GlobalModel> items;

  const TrendaingTvPaginationState(this.items);

  @override
  List<Object?> get props => [items];
}

final class PaginationInitial<T> extends TrendaingTvPaginationState<T> {
  const PaginationInitial() : super(const []);
}

final class TrendaingTvPaginationLoading<T> extends TrendaingTvPaginationState<T> {
  // ignore: use_super_parameters
  const TrendaingTvPaginationLoading(List<T> items) : super(items);
}

final class TrendaingTvPaginationLoaded<T> extends TrendaingTvPaginationState<T> {
  final bool hasMore;

  // ignore: use_super_parameters
  const TrendaingTvPaginationLoaded(List<T> items, {required this.hasMore})
      : super(items);

  @override
  List<Object?> get props => [items, hasMore];
}

final class TrendaingTvPaginationError<T> extends TrendaingTvPaginationState<T> {
  final String error;

  // ignore: use_super_parameters
  const TrendaingTvPaginationError(List<T> items, this.error) : super(items);

  @override
  List<Object?> get props => [items, error];
}
