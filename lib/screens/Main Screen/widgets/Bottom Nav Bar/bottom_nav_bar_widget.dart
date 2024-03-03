import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BottomNavBarWidget {
  final icon;
  final String title;
  final double iconSize;
  final Color selectedIconColor;

  const BottomNavBarWidget({
    required this.icon,
    required this.title,
    required this.iconSize,
    required this.selectedIconColor,
  });
}
