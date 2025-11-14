part of 'english_anime_cubit.dart';

sealed class EnglishAnimeState extends Equatable {
  const EnglishAnimeState();

  @override
  List<Object> get props => [];
}

final class EnglishAnimeInitial extends EnglishAnimeState {}

class EnglishAnimeLoading extends EnglishAnimeState {}

class EnglishAnimeLoaded extends EnglishAnimeState {
  final List<GlobalModel> anime;
  const EnglishAnimeLoaded({required this.anime});
  @override
  List<Object> get props => [anime];
}

class EnglishAnimeFailed extends EnglishAnimeState {
  final String errorMessage;
  const EnglishAnimeFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
