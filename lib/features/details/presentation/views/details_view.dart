import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/features/details/presentation/manger/details/details_cubit.dart';
import 'package:movies_mage/features/details/presentation/manger/favourite/favourite_cubit.dart';
import 'package:movies_mage/features/details/presentation/views/widgets/details_body.dart';

class DetailsScreen extends StatelessWidget {
  final int id;
  final String contentType;

  const DetailsScreen({super.key, required this.id, required this.contentType});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DetailsCubit()..getDetails(id, contentType),
        ),
        BlocProvider(
          create: (context) => FavouritesCubit(),
        ),
      ],
      child: const Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(child: DetailsBody()),
      ),
    );
  }
}
