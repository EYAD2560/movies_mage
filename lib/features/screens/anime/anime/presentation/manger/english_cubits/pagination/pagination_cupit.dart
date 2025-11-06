import 'dart:developer';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'pagination_states.dart';

typedef FetchPage<GlobalModel> = Future<List<GlobalModel>> Function(int page);

class EnglishAnimePagination<GlobalModel> extends Cubit<EnglishAnimePaginationState<GlobalModel>> {
  EnglishAnimePagination({required this.fetchPage}) : super(const PaginationInitial());

  final FetchPage<GlobalModel> fetchPage;

  final List<GlobalModel> _items = [];
  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;

  List<GlobalModel> get items => List.unmodifiable(_items);
  bool get hasMore => _hasMore;

  Future<void> fetchNextPage() async {
    if (_isLoading || !_hasMore || isClosed) return;

    _isLoading = true;
    _safeEmit(EnglishAnimePaginationLoading<GlobalModel>(_items));

    try {
      final newItems = await fetchPage(_currentPage);
      if (isClosed) return;

      if (newItems.isEmpty) {
        _hasMore = false;
      } else {
        _items.addAll(newItems);
        _currentPage++;
      }

      _safeEmit(EnglishAnimePaginationLoaded<GlobalModel>(List.unmodifiable(_items), hasMore: _hasMore));
    } catch (e, s) {
      _safeEmit(EnglishAnimePaginationError<GlobalModel>(_items, e.toString()));
      log('⚠️ Pagination error: $e\n$s');
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
    _safeEmit(const PaginationInitial());
    fetchNextPage();
  }

  void _safeEmit(EnglishAnimePaginationState<GlobalModel> state) {
    if (!isClosed) {
      emit(state);
    } else {
      log('⚠️ Tried to emit after close: $state');
    }
  }
}
