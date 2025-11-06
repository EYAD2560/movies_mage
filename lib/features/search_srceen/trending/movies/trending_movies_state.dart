part of 'trending_movies_cubit.dart';

abstract class TrendingMoviesState extends Equatable {
  const TrendingMoviesState();

  @override
  List<Object> get props => [];
}

class TrendingMoviesInitial extends TrendingMoviesState {}

class TrendingMoviesLoading extends TrendingMoviesState {}

class TrendingMoviesLoaded extends TrendingMoviesState {
  final List<GlobalModel> movies;
  const TrendingMoviesLoaded({required this.movies});

  @override
  List<Object> get props => [movies];
}

class TrendingMoviesFailed extends TrendingMoviesState {
  final String errorMessage;
  const TrendingMoviesFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
