part of 'pagination_cubit.dart';

/// Base state for pagination
sealed class AllTvPaginationState<GlobalModel> extends Equatable {
  final List<GlobalModel> items;

  const AllTvPaginationState(this.items);

  @override
  List<Object?> get props => [items];
}

final class PaginationInitial<T> extends AllTvPaginationState<T> {
  const PaginationInitial() : super(const []);
}

final class AllTvPaginationLoading<T> extends AllTvPaginationState<T> {
  // ignore: use_super_parameters
  const AllTvPaginationLoading(List<T> items) : super(items);
}

final class AllTvPaginationLoaded<T> extends AllTvPaginationState<T> {
  final bool hasMore;

  // ignore: use_super_parameters
  const AllTvPaginationLoaded(List<T> items, {required this.hasMore})
      : super(items);

  @override
  List<Object?> get props => [items, hasMore];
}

final class AllTvPaginationError<T> extends AllTvPaginationState<T> {
  final String error;

  // ignore: use_super_parameters
  const AllTvPaginationError(List<T> items, this.error) : super(items);

  @override
  List<Object?> get props => [items, error];
}
