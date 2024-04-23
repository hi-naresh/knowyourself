import 'package:flutter/material.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

/// Custom Class for Light & Dark Text Themes
class KTextTheme {
  KTextTheme._(); // To avoid creating instances

  /// Customizable Light Text Theme
  static TextTheme lightTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: KSizes.fontSizeXxl, fontWeight: FontWeight.bold, color: KColors.dark),
    headlineMedium: const TextStyle().copyWith(fontSize: KSizes.fontSizeXl, fontWeight: FontWeight.bold, color: KColors.dark),
    headlineSmall: const TextStyle().copyWith(fontSize: KSizes.fontSizeLg, fontWeight: FontWeight.w600, color: KColors.dark),

    titleLarge: const TextStyle().copyWith(fontSize: KSizes.fontSizeMd, fontWeight: FontWeight.w600, color: KColors.dark),
    titleMedium: const TextStyle().copyWith(fontSize: KSizes.fontSizeMd, fontWeight: FontWeight.w500, color: KColors.dark),
    titleSmall: const TextStyle().copyWith(fontSize: KSizes.fontSizeMd, fontWeight: FontWeight.w400, color: KColors.dark),

    bodyLarge: const TextStyle().copyWith(fontSize: KSizes.fontSizeSm, fontWeight: FontWeight.w500, color: KColors.dark),
    bodyMedium: const TextStyle().copyWith(fontSize: KSizes.fontSizeSm, fontWeight: FontWeight.normal, color: KColors.dark),
    bodySmall: const TextStyle().copyWith(fontSize: KSizes.fontSizeSm, fontWeight: FontWeight.w500, color: KColors.dark.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: KSizes.fontSizeXs, fontWeight: FontWeight.normal, color: KColors.dark),
    labelMedium: const TextStyle().copyWith(fontSize: KSizes.fontSizeXs, fontWeight: FontWeight.normal, color: KColors.dark.withOpacity(0.5)),
  );

  /// Customizable Dark Text Theme
  static TextTheme darkTextTheme = TextTheme(
    headlineLarge: const TextStyle().copyWith(fontSize: KSizes.fontSizeXxl, fontWeight: FontWeight.bold, color: KColors.white),
    headlineMedium: const TextStyle().copyWith(fontSize: KSizes.fontSizeXl, fontWeight: FontWeight.w600, color: KColors.white),
    headlineSmall: const TextStyle().copyWith(fontSize: KSizes.fontSizeLg, fontWeight: FontWeight.w600, color: KColors.light),

    titleLarge: const TextStyle().copyWith(fontSize: KSizes.fontSizeMd, fontWeight: FontWeight.w600, color: KColors.white),
    titleMedium: const TextStyle().copyWith(fontSize: KSizes.fontSizeMd, fontWeight: FontWeight.w500, color: KColors.white),
    titleSmall: const TextStyle().copyWith(fontSize: KSizes.fontSizeMd, fontWeight: FontWeight.w400, color: KColors.light),

    bodyLarge: const TextStyle().copyWith(fontSize: KSizes.fontSizeSm, fontWeight: FontWeight.w500, color: KColors.white),
    bodyMedium: const TextStyle().copyWith(fontSize: KSizes.fontSizeSm, fontWeight: FontWeight.normal, color: KColors.light),
    bodySmall: const TextStyle().copyWith(fontSize: KSizes.fontSizeSm, fontWeight: FontWeight.w500, color: KColors.white.withOpacity(0.5)),

    labelLarge: const TextStyle().copyWith(fontSize: KSizes.fontSizeXs, fontWeight: FontWeight.normal, color: KColors.white),
    labelMedium: const TextStyle().copyWith(fontSize: KSizes.fontSizeXs, fontWeight: FontWeight.normal, color: KColors.white.withOpacity(0.5)),
  );
}
