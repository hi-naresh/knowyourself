import 'package:flutter/material.dart';
import '/utils/theme/widget_themes/appbar_theme.dart';
import '/utils/theme/widget_themes/bottom_sheet_theme.dart';
import '/utils/theme/widget_themes/checkbox_theme.dart';
import '/utils/theme/widget_themes/chip_theme.dart';
import '/utils/theme/widget_themes/elevated_button_theme.dart';
import '/utils/theme/widget_themes/outlined_button_theme.dart';
import '/utils/theme/widget_themes/text_field_theme.dart';
import '/utils/theme/widget_themes/text_theme.dart';

import '../constants/colors.dart';

class KAppTheme {
  KAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: KColors.grey,
    brightness: Brightness.light,
    primaryColor: KColors.primary,
    textTheme: KTextTheme.lightTextTheme,
    chipTheme: KChipTheme.lightChipTheme,
    scaffoldBackgroundColor: KColors.scaffoldLight,
    appBarTheme: KAppBarTheme.lightAppBarTheme,
    checkboxTheme: KCheckboxTheme.lightCheckboxTheme,
    bottomSheetTheme: KBottomSheetTheme.lightBottomSheetTheme,
    elevatedButtonTheme: KElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: KOutlinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: KTextFormFieldTheme.lightInputDecorationTheme,
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: KColors.grey,
    brightness: Brightness.dark,
    primaryColor: KColors.primary,
    textTheme: KTextTheme.darkTextTheme,
    chipTheme: KChipTheme.darkChipTheme,
    scaffoldBackgroundColor: KColors.scaffoldDark,
    appBarTheme: KAppBarTheme.darkAppBarTheme,
    checkboxTheme: KCheckboxTheme.darkCheckboxTheme,
    bottomSheetTheme: KBottomSheetTheme.darkBottomSheetTheme,
    elevatedButtonTheme: KElevatedButtonTheme.darkElevatedButtonTheme,
    outlinedButtonTheme: KOutlinedButtonTheme.darkOutlinedButtonTheme,
    inputDecorationTheme: KTextFormFieldTheme.darkInputDecorationTheme,
  );
}
