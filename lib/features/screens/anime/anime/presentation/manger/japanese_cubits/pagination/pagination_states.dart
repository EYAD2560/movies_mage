part of 'pagination_cupit.dart';

abstract class JapaneseAnimePaginationState<GlobalModel> {
  final List<GlobalModel> items;
  const JapaneseAnimePaginationState(this.items);
}

class PaginationInitial<GlobalModel> extends JapaneseAnimePaginationState<GlobalModel> {
  const PaginationInitial() : super(const []);
}

class JapaneseAnimePaginationLoading<GlobalModel> extends JapaneseAnimePaginationState<GlobalModel> {
  // ignore: use_super_parameters
  const JapaneseAnimePaginationLoading(List<GlobalModel> items) : super(items);
}

class JapaneseAnimePaginationLoaded<GlobalModel> extends JapaneseAnimePaginationState<GlobalModel> {
  final bool hasMore;
  // ignore: use_super_parameters
  const JapaneseAnimePaginationLoaded(List<GlobalModel> items, {required this.hasMore}) : super(items);
}

class JapaneseAnimePaginationError<GlobalModel> extends JapaneseAnimePaginationState<GlobalModel> {
  final String error;
  // ignore: use_super_parameters
  const JapaneseAnimePaginationError(List<GlobalModel> items, this.error) : super(items);
}
