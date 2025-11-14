part of 'global_paginator_cubit.dart';

sealed class GlobalPaginatorState<T> extends Equatable {
  final List<T> items;
  const GlobalPaginatorState(this.items);

  @override
  List<Object> get props => [items];
}

final class GlobalPaginatorInitial<T> extends GlobalPaginatorState<T> {
  const GlobalPaginatorInitial() : super(const []);
}

class GlobalPaginationLoading<T> extends GlobalPaginatorState<T> {
  // ignore: use_super_parameters
  const GlobalPaginationLoading(List<T> items) : super(items);
}

class GlobalPaginationLoaded<T> extends GlobalPaginatorState<T> {
  final bool hasMore;
  // ignore: use_super_parameters
  const GlobalPaginationLoaded(List<T> items, {required this.hasMore}) : super(items);

  @override
  List<Object> get props => [items, hasMore];
}

class GlobalPaginationError<T> extends GlobalPaginatorState<T> {
  final String error;
  // ignore: use_super_parameters
  const GlobalPaginationError(List<T> items, this.error) : super(items);

  @override
  List<Object> get props => [items, error];
}
