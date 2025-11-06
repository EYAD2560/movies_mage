// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabTitles;

  const CustomTabBar({
    super.key,
    required this.tabTitles,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: kToolbarHeight + 35,
      left: 15,
      right: 15,
     
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: TabBar(
              physics: const BouncingScrollPhysics(),
              dividerHeight: 0,
              labelColor: Colors.white,
              labelStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelColor: Colors.white60,
              indicator: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: Color(0xAA3356FE),
              ),
              indicatorSize: TabBarIndicatorSize.tab,
              tabs: tabTitles
                  .map((title) => Tab(text: title))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}
