import 'package:flutter/material.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/core/widgets/custom_tapbar.dart';
import 'package:movies_mage/core/widgets/shimmer/person_details_shimmer.dart';
import 'package:movies_mage/features/details/presentation/views/widgets/person_detalis/grid_view.dart';

import 'package:movies_mage/features/details/presentation/views/widgets/person_detalis/data/person_model.dart';
import 'package:movies_mage/features/details/presentation/views/widgets/person_detalis/data/person_service.dart';
import 'package:movies_mage/features/details/presentation/views/widgets/person_detalis/biography/biography_section.dart'; 

class PersonDetails extends StatelessWidget {
  final int personid;
  final PersonService service = PersonService();

  PersonDetails({super.key, required this.personid});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FullPersonModel?>(
      future: service.fetchPersonDetails(personid),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const PersonDetailsShimmer();
        }

        if (!snapshot.hasData || snapshot.hasError) {
          return const Scaffold(
            body: Center(child: Text("Failed to load person details.")),
          );
        }

        final person = snapshot.data!;
        final credits = person.credits;

        return DefaultTabController(
          length: 2,
          child: Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  AllHeadLine(title: person.name),

                  // ✅ Extracted biography section
                  BiographySection(person: person),

                  if (person.placeOfBirth.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        person.placeOfBirth,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    child: CustomTabBar(
                      tabTitles: ['Movies', 'Tv Shows'],
                    ),
                  ),
                  SizedBox(
                    height: 300,
                    child: TabBarView(
                      children: [
                        PersonWorksGrid(
                            items: credits.movies, contentType: 'movie'),
                        PersonWorksGrid(
                            items: credits.tvShows, contentType: 'tv'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
