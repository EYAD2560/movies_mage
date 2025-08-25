import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/details/cupit/details_cubit.dart';
import 'package:movies_mage/details/details_view.dart';
import 'package:movies_mage/details/person_detalis/person_model.dart';
import 'package:movies_mage/details/person_detalis/shows_they_partcipated_in_card.dart';

class PersonWorksGrid extends StatelessWidget {
  final List<MediaWork> items;
  final String contentType;

  const PersonWorksGrid({
    super.key,
    required this.items,
    required this.contentType,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text("No items found."));
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: SizedBox(
        height: 300,
        child: GridView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            final work = items[index];
        
            return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => BlocProvider(
                      create: (_) =>
                          DetailsCubit()..getDetails(work.id, contentType),
                      child: DetailsScreen(contentType: contentType, id: work.id),
                    ),
                  ),
                );
              },
              child: ShowsTheyParticipatedInCard(
                work: work,
                movieId: work.id,
                contenttype: contentType,
              ),
            );
          },
        ),
      ),
    );
  }
}
