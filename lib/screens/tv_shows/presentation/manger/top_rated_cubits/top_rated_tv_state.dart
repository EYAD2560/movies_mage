part of 'top_rated_tv_cubit.dart';

sealed class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

final class TopRatedTvInitial extends TopRatedTvState {}

final class TopRatedTVLoading extends TopRatedTvState {}

final class TopRatedTVLoaded extends TopRatedTvState {
  final List<GlobalModel> shows;
  const TopRatedTVLoaded({required this.shows});

  @override
  List<Object> get props => [shows];
}

final class TopRatedTVFailed extends TopRatedTvState {
  final String errorMessage;
  const TopRatedTVFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
