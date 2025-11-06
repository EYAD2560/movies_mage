import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Custumbuttton extends StatelessWidget {
  const Custumbuttton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
    this.myicon,
  });

  final VoidCallback onPressed;
  final String text;
  final Color color;
  final Image? myicon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 55,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (myicon != null) ...[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: SizedBox(height: 40, width: 40, child: myicon),
                ),
              ],
              Text(
                text,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
