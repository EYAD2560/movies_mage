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

  /// Load favourites safely from local storage
  Future<void> _loadFavourites() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString('favourites');

      if (jsonString != null && jsonString.isNotEmpty) {
        final List<dynamic> decoded = jsonDecode(jsonString);
        final favourites = decoded
            .map((e) => GlobalModel.fromJson(Map<String, dynamic>.from(e)))
            .toList();

        emit(FavouritesState(favourites));
      }
    } catch (e) {
      // Optional: add a logger or handle corrupted data
      emit(const FavouritesState([]));
    }
  }

  /// Add or remove an item from favourites
  Future<void> toggleFavourite(GlobalModel item) async {
    final updatedList = List<GlobalModel>.from(state.favourites);

    final index = updatedList.indexWhere((element) => element.id == item.id);
    if (index != -1) {
      updatedList.removeAt(index);
    } else {
      updatedList.add(item);
    }

    emit(FavouritesState(updatedList));
    await _saveFavourites(updatedList);
  }

  /// Save favourites persistently
  Future<void> _saveFavourites(List<GlobalModel> favourites) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(favourites.map((e) => e.toJson()).toList());
    await prefs.setString('favourites', jsonString);
  }

  /// Check if an item is favourited
  bool isFavourite(int id) {
    return state.favourites.any((favourite) => favourite.id == id);
  }

  /// Remove a favourite explicitly
  Future<void> removeFavourite(GlobalModel item) async {
    final updatedList = List<GlobalModel>.from(state.favourites)
      ..removeWhere((element) => element.id == item.id);

    emit(FavouritesState(updatedList));
    await _saveFavourites(updatedList);
  }
}
