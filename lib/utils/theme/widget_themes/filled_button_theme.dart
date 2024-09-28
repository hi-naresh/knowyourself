import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class KFilledButtonTheme {
  KFilledButtonTheme._(); //To avoid creating instances

  /* -- Light Theme -- */
  static final lightFilledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      elevation: 0,
      foregroundColor: KColors.white,
      backgroundColor: KColors.kApp1,
      disabledForegroundColor: KColors.darkGrey,
      disabledBackgroundColor: KColors.buttonDisabled,
      side: BorderSide.none,
      textStyle: const TextStyle(fontSize: 16, color: KColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(KSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkFilledButtonTheme = FilledButtonThemeData(
    style: FilledButton.styleFrom(
      elevation: 0,
      foregroundColor: KColors.white,
      backgroundColor: KColors.kApp1,
      disabledForegroundColor: KColors.darkGrey,
      disabledBackgroundColor: KColors.darkerGrey,
      side: const BorderSide(color: KColors.primary),
      textStyle: const TextStyle(fontSize: 16, color: KColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(KSizes.buttonRadius)),
    ),
  );
}