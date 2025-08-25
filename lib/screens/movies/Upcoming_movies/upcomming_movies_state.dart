part of 'upcomming_movies_cubit.dart';

abstract class UpcommingMoviesStates {}

class MoviesInitial extends UpcommingMoviesStates {}

class MoviesLoading extends UpcommingMoviesStates {}

class MoviesLoaded extends UpcommingMoviesStates {
  final List<Map<String, dynamic>> posters;
  MoviesLoaded(this.posters);
}

class MoviesLoadFailed extends UpcommingMoviesStates {}
