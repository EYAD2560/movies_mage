import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/screens/tv_shows/upcomming_tv.dart/upcoming_tvshows_cubit.dart';
import 'package:movies_mage/screens/tv_shows/tv_shows_body.dart';

class TvShowsView extends StatelessWidget {
  const TvShowsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpcomingTvshowsCubit(),
      child: const Scaffold(body: TvShowsPageBody()),
    );
  }
}
