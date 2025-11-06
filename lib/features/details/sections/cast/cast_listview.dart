import 'package:flutter/material.dart';
import 'package:movies_mage/features/details/sections/cast/cast_model.dart';
import 'package:movies_mage/features/details/sections/cast/cast_service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_mage/features/details/person_detalis/person_details.dart';

class CastListView extends StatelessWidget {
  final int id;
  final String contentType;

  const CastListView({
    super.key,
    required this.id,
    required this.contentType,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: CastService().fetchCastAndDirector(id: id, contentType: contentType),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox.shrink();
        }

        final cast = snapshot.data!['cast'] as List<CastModel>;
        final DirectorModel? director = snapshot.data!['director'];

        // ===== No data for both cast and director =====
        if ((cast.isEmpty) && (director == null || director.profilePath == null || director.profilePath!.isEmpty)) {
          return SizedBox() ; 
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ======== Director Section ========
            if (director != null && director.profilePath != null && director.profilePath!.isNotEmpty) ...[
              const Text(
                'Director',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PersonDetails(personid: director.id),
                    ),
                  );
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: 'https://image.tmdb.org/t/p/original${director.profilePath}',
                        imageBuilder: (context, imageProvider) => CircleAvatar(
                          radius: 40,
                          backgroundImage: imageProvider,
                        ),
                        placeholder: (context, url) => const CircleAvatar(
                          radius: 35,
                          backgroundColor: Colors.blueGrey,
                        ),
                        errorWidget: (context, url, error) => const CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage(''),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          director.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'Director',
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
            ],

            // ======== Cast Section ========
            if (cast.isNotEmpty) ...[
              const Text(
                'Top Cast',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 130,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: cast.length,
                  itemBuilder: (context, index) {
                    final actor = cast[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => PersonDetails(personid: actor.id),
                          ),
                        );
                      },
                      child: Container(
                        width: 100,
                        margin: const EdgeInsets.only(right: 12),
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: actor.profilePath != null && actor.profilePath!.isNotEmpty
                                  ? 'https://image.tmdb.org/t/p/original${actor.profilePath}'
                                  : '',
                              imageBuilder: (context, imageProvider) => CircleAvatar(
                                radius: 35,
                                backgroundImage: imageProvider,
                              ),
                              placeholder: (context, url) => const CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.blueGrey,
                              ),
                              errorWidget: (context, url, error) => const CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage('assets/empty image .jpg'),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              actor.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              actor.character,
                              style: const TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ],
          
        );
      },
    );
  }
}
