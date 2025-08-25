import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favourite_state.dart';

class FavouritesCubit extends Cubit<FavouritesState> {
  FavouritesCubit() : super(const FavouritesState([])) {
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString('favourites');
    if (jsonString != null) {
      final List decoded = jsonDecode(jsonString);
      final favourites = decoded
          .map((e) => GlobalModel.fromJson(Map<String, dynamic>.from(e)))
          .toList();

      emit(FavouritesState(favourites));
    }
  }

  Future<void> toggleFavourite(GlobalModel favouriteitem) async {
    final updatedList = List<GlobalModel>.from(state.favourites);

    if (updatedList.any((element) => element.id == favouriteitem.id)) {
      updatedList.removeWhere((element) => element.id == favouriteitem.id);
    } else {
      updatedList.add(favouriteitem);
    }

    emit(FavouritesState(updatedList));
    await _saveFavourites(updatedList);
  }

  Future<void> _saveFavourites(List<GlobalModel> favourites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(favourites.map((e) => e.toJson()).toList());
    await prefs.setString('favourites', jsonString);
  }

  bool isFavourite(int id) {
    return state.favourites.any((favouriteitem) => favouriteitem.id == id);
  }

  Future<void> removeFavourite(GlobalModel favouriteItem) async {
    final updatedList = List<GlobalModel>.from(state.favourites)
      ..removeWhere((element) => element.id == favouriteItem.id);

    emit(FavouritesState(updatedList));
    await _saveFavourites(updatedList);
  }
}
