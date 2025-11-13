part of 'nowplaying_cubit.dart';

sealed class NowplayingState extends Equatable {
  const NowplayingState();

  @override
  List<Object> get props => [];
}

final class NowplayingInitial extends NowplayingState {}


final class NowPlayingLoading extends NowplayingState {}
final class NowPlayingLoaded extends NowplayingState {
  final List<GlobalModel> movies;

  const NowPlayingLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}
final class NowPlayingFailed extends NowplayingState {
  final String errorMessage;

  const NowPlayingFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
