part of 'all_tv_cubit_cubit.dart';

sealed class AllTvCubitState extends Equatable {
  const AllTvCubitState();

  @override
  List<Object> get props => [];
}

final class AllTvCubitInitial extends AllTvCubitState {}

final class AllTVLoading extends AllTvCubitState {}

final class AllTVLoaded extends AllTvCubitState {
  final List<GlobalModel> shows;
  const AllTVLoaded({required this.shows});

  @override
  List<Object> get props => [shows];
}

final class AllTVFailed extends AllTvCubitState {
  final String errorMessage;
  const AllTVFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
