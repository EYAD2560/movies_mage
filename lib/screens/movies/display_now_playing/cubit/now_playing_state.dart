part of 'now_playing_cubit.dart';

sealed class NowPlayingState extends Equatable {
  const NowPlayingState();

  @override
  List<Object?> get props => [];
}

final class NowPlayingInitial extends NowPlayingState {
  const NowPlayingInitial();
}

final class NowPlayingLoading extends NowPlayingState {
  const NowPlayingLoading();
}

final class NowPlayingLoaded extends NowPlayingState {
  final List<GlobalModel> movies;
  const NowPlayingLoaded({required this.movies});

  @override
  List<Object?> get props => [movies];
}

final class NowPlayingFailed extends NowPlayingState {
  final String errorMessage;
  const NowPlayingFailed({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
