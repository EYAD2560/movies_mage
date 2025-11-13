import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/features/homepage/presentaion/maneger/login/logincupit_cubit.dart';
import 'package:movies_mage/features/main_menu/presentaion/views/widgets/settings/settings_screen.dart';

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