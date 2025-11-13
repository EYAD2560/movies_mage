import 'package:flutter/material.dart';

class Trendingbar extends StatelessWidget {
  const Trendingbar({
    super.key,
    required this.title,
    this.ontap,
  });
  final String title;
  final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.only(right: 6, bottom: 10),
        child: Row(
          children: [
           Text(
              title,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Spacer(),
            GestureDetector(
              onTap: ontap ,
              child: Text(
                "View all",
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
