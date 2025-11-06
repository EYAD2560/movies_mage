part of 'upcoming_tvshows_cubit.dart';

abstract class TvShowsStates {}

class TvShowsInitial extends TvShowsStates {}

class TvShowsLoading extends TvShowsStates {}

class TvShowsLoaded extends TvShowsStates {
  final List<Map<String, dynamic>> posters;
  TvShowsLoaded(this.posters);
}

class TvShowsLoadingFailed extends TvShowsStates {}
