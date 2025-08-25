import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:movies_mage/details/person_detalis/biography/biography_page.dart';
import 'package:movies_mage/details/person_detalis/person_model.dart';

class BiographySection extends StatelessWidget {
  final FullPersonModel person;

  const BiographySection({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    // ✅ Case 1: No biography → show image centered
    if (person.biography.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 40),
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: person.profilePath.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: person.profilePath,
                    height: 220,
                    width: 150,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 220,
                      width: 150,
                      color: Colors.blueGrey,
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 220,
                      width: 150,
                      color: Colors.blueGrey,
                      child: Image.asset('assets/empty image .jpg'),
                    ),
                  )
                : Container(
                    height: 220,
                    width: 150,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade300,
                    ),
                    child:
                        const Icon(Icons.person, size: 70, color: Colors.grey),
                  ),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: person.profilePath.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: person.profilePath,
                    height: 200,
                    width: 130,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => Container(
                      height: 200,
                      width: 130,
                      color: Colors.blueGrey,
                    ),
                    errorWidget: (context, url, error) => Container(
                      height: 200,
                      width: 130,
                      color: Colors.blueGrey,
                      child: Image.asset('assets/empty image .jpg'),
                    ),
                  )
                : Container(
                    height: 200,
                    width: 130,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey.shade300,
                    ),
                    child:
                        const Icon(Icons.person, size: 60, color: Colors.grey),
                  ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: SizedBox(
              height: 200,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    person.biography,
                    maxLines: 7,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BiographyPage(
                            personname: person.name,
                            biography: person.biography,
                          ),
                        ),
                      );
                    },
                    child: const Text(
                      "Read more",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
