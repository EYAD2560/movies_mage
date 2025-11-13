part of 'details_cubit.dart';

@immutable
abstract class DetailsState {}

class DetailsInitial extends DetailsState {}

class DetailsLoading extends DetailsState {
  
}

class DetailsSuccess extends DetailsState {
  final dynamic data;
  final List<String> genres;
  final String contentType;

  DetailsSuccess(this.data, this.genres, this.contentType);
}

class DetailsFailed extends DetailsState {
  final String error;

  DetailsFailed({required this.error});
}
