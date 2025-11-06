import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/core/widgets/return_button.dart';
import 'package:movies_mage/details/favourite/cubit/cupit/favourite_cubit.dart';
class DetailsBar extends StatelessWidget {
  const DetailsBar({
    super.key,
    required this.model,
  });

  final GlobalModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const ReturnButton(),
        const SizedBox(width: 250),
        BlocBuilder<FavouritesCubit, FavouritesState>(
          builder: (context, favState) {
            final isFav = context
                .read<FavouritesCubit>()
                .isFavourite(model.id);
            return IconButton(
              icon: Icon(
                isFav ? Icons.favorite : Icons.favorite_border,
                color: isFav ? Colors.red : Colors.white,
              ),
              onPressed: () {
                context.read<FavouritesCubit>().toggleFavourite(
                    GlobalModel(
                        id: model.id,
                        name: model.name,
                        overview: model.overview,
                        poster: model.poster,
                        releaseDate: model.releaseDate,
                        rate: model.rate,
                        genres: model.genres,
                        mediaType: model.mediaType,
                        backdropImage: model.backdropImage));
              },
            );
          },
        ),
      ],
    );
  }
}
