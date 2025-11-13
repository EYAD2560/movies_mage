import 'package:flutter/material.dart';
import 'package:movies_mage/features/main_menu/presentaion/views/main_screen.dart';
import 'package:movies_mage/features/search_srceen/presentaion/views/search_screen.dart';
class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: Colors.transparent),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/mylogo2-removebg-preview.png',
                  width: 70,
                  height: 70,
                ),
                Row(children: [
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return SearchScreen();
                        }));
                      },
                      icon: Icon(Icons.search, size: 25)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (context) {
                              return MainScreen();
                            }));
                      },
                      icon: Icon(Icons.menu))
                ])
              ],
            ),
          ],
        ),
      ),
    );
  }
}
