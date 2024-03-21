import 'package:flutter/material.dart';
import '../../constants/colors.dart';

class KChipTheme {
  KChipTheme._();

  static ChipThemeData lightChipTheme = ChipThemeData(
    disabledColor: KColors.grey.withOpacity(0.4),
    labelStyle: const TextStyle(color: KColors.black),
    selectedColor: KColors.primary,
    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: KColors.white,
  );

  static ChipThemeData darkChipTheme = const ChipThemeData(
    disabledColor: KColors.darkerGrey,
    labelStyle: TextStyle(color: KColors.white),
    selectedColor: KColors.primary,
    padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12),
    checkmarkColor: KColors.white,
  );
}
