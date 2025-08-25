import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/screens/anime/anime/anime_body.dart';
import 'package:movies_mage/screens/anime/anime/upcomming_anime/upcomming_anime_cubit.dart';

class AnimeView extends StatelessWidget {
  const AnimeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpcommingAnimeCubit()..showAnime(),
      child: const Scaffold(body: AnimeBody()),
    );
  }
}
