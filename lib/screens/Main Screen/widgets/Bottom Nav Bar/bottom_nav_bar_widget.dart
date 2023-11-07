import 'package:flutter/material.dart';

class BottomNavBarWidget {
  final IconData iconData;
  final double iconSize;
  final String title;
  final Color selectedIconColor;

  const BottomNavBarWidget({
    required this.title,
    required this.iconData,
    required this.iconSize,
    required this.selectedIconColor,
  });
}
