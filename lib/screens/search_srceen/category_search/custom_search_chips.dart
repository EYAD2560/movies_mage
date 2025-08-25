import 'package:flutter/material.dart';

class CustomSearchChips extends StatelessWidget {
  const CustomSearchChips(
      {super.key, required this.category, required this.color, this.ontap});
  final String category;
  final Color color;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            child: Center(
                child: Text(
              category,
              style: const TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            )),
          )),
    );
  }
}
