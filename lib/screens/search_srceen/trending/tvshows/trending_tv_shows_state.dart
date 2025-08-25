part of 'trending_tv_shows_cubit.dart';

sealed class TrendingTvShowsState extends Equatable {
  const TrendingTvShowsState();

  @override
  List<Object> get props => [];
}

class TrendingTvInitial extends TrendingTvShowsState {}

class TrendingTvLoading extends TrendingTvShowsState {}

class TrendingTvLoaded extends TrendingTvShowsState {
  final List<GlobalModel> movies;
  const TrendingTvLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class TrendingTvFailed extends TrendingTvShowsState {
  final String errorMessage;
  const TrendingTvFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
