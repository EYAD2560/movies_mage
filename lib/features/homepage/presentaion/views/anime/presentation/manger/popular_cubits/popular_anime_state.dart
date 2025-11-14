part of 'popular_anime_cubit.dart';

sealed class PopularAnimeState extends Equatable {
  const PopularAnimeState();

  @override
  List<Object> get props => [];
}

final class PopularAnimeInitial extends PopularAnimeState {}
class NowPlayingAnimeLoading extends PopularAnimeState {}
class NowPlayingAnimeLoaded extends PopularAnimeState {
  final List<GlobalModel> anime;
  const NowPlayingAnimeLoaded({required this.anime});
  @override
  List<Object> get props => [anime];
}
class NowPlayingAnimeFailed extends PopularAnimeState {
  final String errorMessage;
  const NowPlayingAnimeFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
