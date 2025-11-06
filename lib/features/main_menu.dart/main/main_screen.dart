import 'package:flutter/material.dart';
import 'package:movies_mage/core/widgets/all_head_line.dart';
import 'package:movies_mage/features/main_menu.dart/favourite/favourite_view.dart';
import 'package:movies_mage/features/main_menu.dart/main/menu_charts.dart';
import 'package:movies_mage/features/main_menu.dart/settings/settings_screen_view.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
      child: Scaffold(
        body: Column(
          children: [
          const  AllHeadLine(title: 'Main Menu'),
            MenuCharts(
              title: "Favourite",
              myicon: Icons.favorite,
              ontap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return const FavouriteView();
                }));
              },
            ),
            MenuCharts(
              title: "Settings",
              myicon: Icons.settings,
              ontap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SettingsScreenView();
                    },
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
