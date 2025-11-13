import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'pagination_state.dart';
typedef FetchPage<GlobalModel> = Future<List<GlobalModel>> Function(int page);

class TrendaingTvPaginationCubit<GlobalModel>
    extends Cubit<TrendaingTvPaginationState<GlobalModel>> {
  TrendaingTvPaginationCubit({required this.fetchPage})
      : super(const PaginationInitial());

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
    _safeEmit(TrendaingTvPaginationLoading<GlobalModel>(_items));

    try {
      final newItems = await fetchPage(_currentPage);
      if (isClosed) return;

      if (newItems.isEmpty) {
        _hasMore = false;
      } else {
        _items.addAll(newItems);
        _currentPage++;
      }

      _safeEmit(TrendaingTvPaginationLoaded<GlobalModel>(
        List.unmodifiable(_items),
        hasMore: _hasMore,
      ));
    } catch (e) {
      _safeEmit(TrendaingTvPaginationError<GlobalModel>(_items, e.toString()));
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

  void _safeEmit(TrendaingTvPaginationState<GlobalModel> state) {
    if (!isClosed) emit(state);
  }
}

