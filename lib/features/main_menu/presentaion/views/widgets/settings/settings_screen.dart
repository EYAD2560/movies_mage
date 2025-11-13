import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/features/auth/presentaion/maneger/login/logincupit_cubit.dart';
import 'package:movies_mage/features/auth/presentaion/maneger/login/logincupit_state.dart';
import 'package:movies_mage/features/auth/presentaion/widgets/login/login_screen_view.dart';
import 'package:movies_mage/features/main_menu/presentaion/views/widgets/menu_charts.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(), // ❌ Cancel
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
            onPressed: () {
              Navigator.of(context).pop(); // Close the dialog
              context.read<LoginCubit>().signOut();
            },
            child: const Text("Log Out"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            }
            if (state is Logoutfailed) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Logout failed: ${state.error}')),
              );
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const AllHeadLine(title: 'Settings'),
              GestureDetector(
                onTap: () => _showLogoutDialog(context),
                child: const MenuCharts(
                  title: 'Log Out',
                  myicon: Icons.exit_to_app,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
