part of 'pagination_cubit.dart';

/// Base state for pagination
sealed class TrendingMoviesPaginationState<GlobalModel> extends Equatable {
  final List<GlobalModel> items;

  const TrendingMoviesPaginationState(this.items);

  @override
  List<Object?> get props => [items];
}

final class PaginationInitial<T> extends TrendingMoviesPaginationState<T> {
  const PaginationInitial() : super(const []);
}

final class TrendingMoviesPaginationLoading<T> extends TrendingMoviesPaginationState<T> {
  // ignore: use_super_parameters
  const TrendingMoviesPaginationLoading(List<T> items) : super(items);
}

final class TrendingMoviesPaginationLoaded<T> extends TrendingMoviesPaginationState<T> {
  final bool hasMore;

  // ignore: use_super_parameters
  const TrendingMoviesPaginationLoaded(List<T> items, {required this.hasMore})
      : super(items);

  @override
  List<Object?> get props => [items, hasMore];
}

final class TrendingMoviesPaginationError<T> extends TrendingMoviesPaginationState<T> {
  final String error;

  // ignore: use_super_parameters
  const TrendingMoviesPaginationError(List<T> items, this.error) : super(items);

  @override
  List<Object?> get props => [items, error];
}
