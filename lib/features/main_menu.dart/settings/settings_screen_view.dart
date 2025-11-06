import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/features/homepage/login/cupit/logincupit_cubit.dart';
import 'package:movies_mage/features/main_menu.dart/settings/settings_screen.dart';

class SettingsScreenView extends StatelessWidget {
  const SettingsScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: const SettingsScreen(),
    );
  }
}