import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Elevated Button Themes -- */
class KElevatedButtonTheme {
  KElevatedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightElevatedButtonTheme  = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: KColors.white,
      backgroundColor: KColors.primary,
      disabledForegroundColor: KColors.darkGrey,
      disabledBackgroundColor: KColors.buttonDisabled,
      minimumSize: const Size(double.infinity, KSizes.buttonHeight),
      side: BorderSide.none,
      textStyle: const TextStyle(fontSize: 18, color: KColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(KSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: KColors.white,
      backgroundColor: KColors.primary,
      disabledForegroundColor: KColors.darkGrey,
      disabledBackgroundColor: KColors.darkerGrey,
      minimumSize: const Size(double.infinity, KSizes.buttonHeight),
      side: BorderSide.none,
      textStyle: const TextStyle(fontSize: 18, color: KColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(KSizes.buttonRadius)),
    ),
  );
}
