part of 'pagination_cubit.dart';

/// Base state for pagination
sealed class CategorySearchPaginationState<GlobalModel> extends Equatable {
  final List<GlobalModel> items;

  const CategorySearchPaginationState(this.items);

  @override
  List<Object?> get props => [items];
}

final class PaginationInitial<T> extends CategorySearchPaginationState<T> {
  const PaginationInitial() : super(const []);
}

final class CategorySearchPaginationLoading<T> extends CategorySearchPaginationState<T> {
  // ignore: use_super_parameters
  const CategorySearchPaginationLoading(List<T> items) : super(items);
}

final class CategorySearchPaginationLoaded<T> extends CategorySearchPaginationState<T> {
  final bool hasMore;

  // ignore: use_super_parameters
  const CategorySearchPaginationLoaded(List<T> items, {required this.hasMore})
      : super(items);

  @override
  List<Object?> get props => [items, hasMore];
}

final class CategorySearchPaginationError<T> extends CategorySearchPaginationState<T> {
  final String error;

  // ignore: use_super_parameters
  const CategorySearchPaginationError(List<T> items, this.error) : super(items);

  @override
  List<Object?> get props => [items, error];
}
