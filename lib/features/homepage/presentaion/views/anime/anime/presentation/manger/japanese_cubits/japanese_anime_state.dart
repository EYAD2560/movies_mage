part of 'japanese_anime_cubit.dart';

sealed class JapaneseAnimeState extends Equatable {
  const JapaneseAnimeState();

  @override
  List<Object> get props => [];
}

final class JapaneseAnimeInitial extends JapaneseAnimeState {}
class JapaneseAnimeLoading extends JapaneseAnimeState {}
class JapaneseAnimeLoaded extends JapaneseAnimeState {
  final List<GlobalModel> anime;
  const JapaneseAnimeLoaded({required this.anime});
  @override
  List<Object> get props => [anime];
}
class JapaneseAnimeFailed extends JapaneseAnimeState {
  final String errorMessage;
  const JapaneseAnimeFailed({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}

