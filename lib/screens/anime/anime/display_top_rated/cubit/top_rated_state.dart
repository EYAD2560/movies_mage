part of 'top_rated_cubit.dart';

sealed class TopRatedAnimeState extends Equatable {
  const TopRatedAnimeState();

  @override
  List<Object> get props => [];
}

final class TopRatedInitial extends TopRatedAnimeState {}
class TopRatedAnimeLoading extends TopRatedAnimeState {}
class TopRatedAnimeLoaded extends TopRatedAnimeState {
  final List<GlobalModel> anime;
  const TopRatedAnimeLoaded({required this.anime});
  @override
  List<Object> get props => [anime];
}
class TopRatedAnimeFailed extends TopRatedAnimeState {
  final String errorMessage;
  const TopRatedAnimeFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

