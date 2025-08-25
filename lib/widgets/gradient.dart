import 'package:flutter/material.dart';

class ImageGradient extends StatelessWidget {
  const ImageGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.black,
            Color(0x80000000),
            Color(0x00000000),
            Color(0x00000000),
            Color(0x00000000),
            Color(0x00000000),
          ],
        ),
      ),
    );
  }
}
