part of "favourite_cubit.dart";

class FavouritesState extends Equatable {
  final List<GlobalModel> favourites;
  const FavouritesState(this.favourites);

  @override
  List<Object> get props => [favourites];
}
