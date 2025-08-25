part of 'now_playing_tv_cubit.dart';

sealed class NowPlayingTvState extends Equatable {
  const NowPlayingTvState();

  @override
  List<Object> get props => [];
}

final class NowPlayingTvInitial extends NowPlayingTvState {}

final class AiringTVLoading extends NowPlayingTvState {}

final class AiringTVLoaded extends NowPlayingTvState {
  final List<GlobalModel> shows;
  const AiringTVLoaded({required this.shows});

  @override
  List<Object> get props => [shows];
}

final class AiringTVFailed extends NowPlayingTvState {
  final String errorMessage;
  const AiringTVFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
