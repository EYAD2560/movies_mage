part of 'all_movies_cubit.dart';

sealed class AllMoviesState extends Equatable {
  const AllMoviesState();

  @override
  List<Object?> get props => [];
}

final class AllMoviesInitial extends AllMoviesState {
  const AllMoviesInitial();
}

final class AllMoviesLoading extends AllMoviesState {
  const AllMoviesLoading();
}

final class AllMoviesLoaded extends AllMoviesState {
  final List<GlobalModel> movies;
  const AllMoviesLoaded({required this.movies});

  @override
  List<Object?> get props => [movies];
}

final class AllMoviesFailed extends AllMoviesState {
  final String errorMessage;
  const AllMoviesFailed({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
