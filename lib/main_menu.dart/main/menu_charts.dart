import 'package:flutter/material.dart';

class MenuCharts extends StatelessWidget {
  const MenuCharts({
    super.key,
    required this.title,
    required this.myicon,
    this.ontap,
  });
  final String title;
  final IconData myicon;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: GestureDetector(
        onTap: ontap,
        child: Container(
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: Color(0xff1E1E1E)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                Spacer(),
                Icon(myicon)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
