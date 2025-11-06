import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/screens/movies/Upcoming_movies/upcomming_movies_cubit.dart';
import 'package:movies_mage/screens/movies/presentation/views/widgets/movies_page_body.dart';

class MoviespageView extends StatelessWidget {
  const MoviespageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => MoviesCubit()..showMovies(),
      child: const MoviesPagebody(),
      ),
    );
  }
}
