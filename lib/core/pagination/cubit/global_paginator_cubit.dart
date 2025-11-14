import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'global_paginator_state.dart';

typedef FetchPage<T> = Future<List<T>> Function(int page);

class GlobalPaginatorCubit<T> extends Cubit<GlobalPaginatorState<T>> {
  final FetchPage<T> fetchPage;

  GlobalPaginatorCubit({required this.fetchPage})
      : super(const GlobalPaginatorInitial());

  final List<T> _items = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  List<T> get items => List.unmodifiable(_items);
  bool get hasMore => _hasMore;

  Future<void> fetchNextPage() async {
    if (_isLoading || !_hasMore || isClosed) return;

    _isLoading = true;
    _safeEmit(EnglishAnimePaginationLoading<T>(_items));

    try {
      final newItems = await fetchPage(_currentPage);
      if (isClosed) return;

      if (newItems.isEmpty) {
        _hasMore = false;
      } else {
        _items.addAll(newItems);
        _currentPage++;
      }

      _safeEmit(EnglishAnimePaginationLoaded<T>(
        List.unmodifiable(_items),
        hasMore: _hasMore,
      ));
    } catch (e, s) {
      log("⚠️ Pagination Error: $e\n$s");
      _safeEmit(EnglishAnimePaginationError<T>(_items, e.toString()));
    } finally {
      _isLoading = false;
    }
  }

  void reset() {
    if (isClosed) return;

    _items.clear();
    _currentPage = 1;
    _hasMore = true;
    _isLoading = false;

    _safeEmit(const GlobalPaginatorInitial());
    fetchNextPage();
  }

  void _safeEmit(GlobalPaginatorState<T> state) {
    if (!isClosed) {
      emit(state);
    } else {
      log("⚠️ Tried to emit after close: $state");
    }
  }
}
