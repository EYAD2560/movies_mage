part of 'upcomming_anime_cubit.dart';

abstract class AnimeStates {}

class AnimeInitial extends AnimeStates {}

class AnimeLoading extends AnimeStates {}

class AnimeLoaded extends AnimeStates {
  final List<Map<String, dynamic>> posters;
  AnimeLoaded(this.posters);
}

class AnimeLoadingFailed extends AnimeStates {}

