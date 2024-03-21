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
      foregroundColor: KColors.light,
      backgroundColor: KColors.primary,
      disabledForegroundColor: KColors.darkGrey,
      disabledBackgroundColor: KColors.buttonDisabled,
      side: const BorderSide(color: KColors.primary),
      // shadowColor: KColors.primary.withOpacity(0.95),
      // padding: const EdgeInsets.symmetric(vertical: KSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: KColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(KSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: KColors.light,
      backgroundColor: KColors.primary,
      disabledForegroundColor: KColors.darkGrey,
      disabledBackgroundColor: KColors.darkerGrey,
      side: const BorderSide(color: KColors.primary),
      // padding: const EdgeInsets.symmetric(vertical: KSizes.buttonHeight),
      textStyle: const TextStyle(fontSize: 16, color: KColors.textWhite, fontWeight: FontWeight.w600),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(KSizes.buttonRadius)),
    ),
  );
}
