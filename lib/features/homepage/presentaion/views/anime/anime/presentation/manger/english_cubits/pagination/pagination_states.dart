part of 'pagination_cupit.dart';

abstract class EnglishAnimePaginationState<GlobalModel> {
  final List<GlobalModel> items;
  const EnglishAnimePaginationState(this.items);
}

class PaginationInitial<GlobalModel> extends EnglishAnimePaginationState<GlobalModel> {
  const PaginationInitial() : super(const []);
}

class EnglishAnimePaginationLoading<GlobalModel> extends EnglishAnimePaginationState<GlobalModel> {
  // ignore: use_super_parameters
  const EnglishAnimePaginationLoading(List<GlobalModel> items) : super(items);
}

class EnglishAnimePaginationLoaded<GlobalModel> extends EnglishAnimePaginationState<GlobalModel> {
  final bool hasMore;
  // ignore: use_super_parameters
  const EnglishAnimePaginationLoaded(List<GlobalModel> items, {required this.hasMore}) : super(items);
}

class EnglishAnimePaginationError<GlobalModel> extends EnglishAnimePaginationState<GlobalModel> {
  final String error;
  // ignore: use_super_parameters
  const EnglishAnimePaginationError(List<GlobalModel> items, this.error) : super(items);
}
