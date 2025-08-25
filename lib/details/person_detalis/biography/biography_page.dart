import 'package:flutter/material.dart';
import 'package:movies_mage/widgets/all_head_line.dart';

class BiographyPage extends StatelessWidget {
  const BiographyPage(
      {super.key, required this.personname, required this.biography});
  final String personname;
  final String biography;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              AllHeadLine(title: personname),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Text(
                  biography,
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
