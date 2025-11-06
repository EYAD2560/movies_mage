import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/features/details/favourite/cubit/cupit/favourite_cubit.dart';
import 'package:movies_mage/core/global_model.dart';
import 'package:movies_mage/features/details/widgets/favourite_listview.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AllHeadLine(title: 'Favourite'),
            Expanded(
              child: BlocBuilder<FavouritesCubit, FavouritesState>(
                builder: (context, state) {
                  if (state.favourites.isEmpty) {
                    return const Center(child: Text("No favourites yet"));
                  }

                  return ListView.builder(
                    itemCount: state.favourites.length,
                    itemBuilder: (context, index) {
                      final GlobalModel item = state.favourites[index];

                      return Dismissible(
                        key: ValueKey(item.id),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: const Icon(Icons.delete, color: Colors.white),
                        ),
                        onDismissed: (_) {
                          context.read<FavouritesCubit>().removeFavourite(item);
                        },
                        child: FavouriteListView(
                          scrollController: ScrollController(),
                          items: [item],
                          showShimmer: false,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
