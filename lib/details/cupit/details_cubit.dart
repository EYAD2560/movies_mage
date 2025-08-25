import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/details/movie_details_service.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(DetailsInitial());

  Future<void> getDetails(int id, String contentType) async {
    emit(DetailsLoading());
    try {
      if (contentType == "movie") {
        final movie = await MovieDetailsService().fetchMovieDetails(id);
        emit(DetailsSuccess(movie, movie.genres, contentType));
      } else if (contentType == "tv" || contentType == "anime") {
        final tvShow = await MovieDetailsService().fetchTvShowDetails(id);
        emit(DetailsSuccess(tvShow, tvShow.genres, contentType));
      } else {
        emit(DetailsFailed(error: "Unsupported content type: $contentType"));
      }
    } catch (e) {
    log("error: $e");
      emit(DetailsFailed(error: e.toString()));
    }
  }
}
