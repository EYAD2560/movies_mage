part of 'top_rated_cubit.dart';

sealed class TopRatedState extends Equatable {
  const TopRatedState();

  @override
  List<Object?> get props => [];
}

final class TopRatedInitial extends TopRatedState {
  const TopRatedInitial();
}

final class TopRatedLoading extends TopRatedState {
  const TopRatedLoading();
}

final class TopRatedLoaded extends TopRatedState {
  final List<GlobalModel> movies;
  const TopRatedLoaded({required this.movies});

  @override
  List<Object?> get props => [movies];
}

final class TopRatedFailed extends TopRatedState {
  final String errorMessage;
  const TopRatedFailed({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
