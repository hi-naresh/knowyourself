import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/* -- Light & Dark Outlined Button Themes -- */
class KOutlinedButtonTheme {
  KOutlinedButtonTheme._(); //To avoid creating instances


  /* -- Light Theme -- */
  static final lightOutlinedButtonTheme  = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      elevation: 0,
      foregroundColor: KColors.dark,
      side: const BorderSide(color: KColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: KColors.black, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: KSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(KSizes.buttonRadius)),
    ),
  );

  /* -- Dark Theme -- */
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: KColors.light,
      side: const BorderSide(color: KColors.borderPrimary),
      textStyle: const TextStyle(fontSize: 16, color: KColors.textWhite, fontWeight: FontWeight.w600),
      padding: const EdgeInsets.symmetric(vertical: KSizes.buttonHeight, horizontal: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(KSizes.buttonRadius)),
    ),
  );
}
