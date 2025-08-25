import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_mage/screens/search_srceen/sevices/search_service.dart';
import 'package:movies_mage/core/global_model.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  Timer? _debounce;

  Future<void> search(String query) async {
    // ✅ Cancel any previous scheduled search
    _debounce?.cancel();

    // ✅ Wait 400ms before firing (prevents overlap)
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      if (isClosed) return;

      emit(SearchLoading());

      try {
        final results = await SearchService().search(query);

        if (isClosed) return; // safe check after async
        emit(SearchLoaded(results));
      } catch (e) {
        if (isClosed) return;
        emit(SearchError(e.toString()));
      }
    });
  }

  void reset() {
    _debounce?.cancel(); // ✅ Cancel pending search
    if (!isClosed) emit(SearchInitial());
  }

  @override
  Future<void> close() {
    _debounce?.cancel(); // ✅ cleanup on dispose
    return super.close();
  }
}
