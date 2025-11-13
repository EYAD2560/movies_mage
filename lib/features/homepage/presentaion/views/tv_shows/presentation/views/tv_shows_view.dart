import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/features/homepage/presentaion/views/tv_shows/presentation/views/widgets/tv_shows_body.dart';
import 'package:movies_mage/features/homepage/presentaion/views/tv_shows/presentation/manger/upcomming_tv.dart/upcoming_tvshows_cubit.dart';


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
