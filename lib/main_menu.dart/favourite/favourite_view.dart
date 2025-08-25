import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/main_menu.dart/favourite/favourite_screen.dart';
import 'package:movies_mage/details/favourite/cubit/cupit/favourite_cubit.dart';

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavouritesCubit(),
      child: FavouriteScreen(),
    );
  }
}