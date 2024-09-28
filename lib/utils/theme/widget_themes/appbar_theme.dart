import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../constants/colors.dart';
import '../../constants/sizes.dart';

class KAppBarTheme{
  KAppBarTheme._();

  static const lightAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor:KColors.transparent,
    surfaceTintColor:KColors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.dark,
    iconTheme: IconThemeData(color: KColors.dark, size: KSizes.iconLg),
    actionsIconTheme: IconThemeData(color: KColors.dark, size: KSizes.iconLg),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: KColors.black),
  );
  static const darkAppBarTheme = AppBarTheme(
    elevation: 0,
    centerTitle: false,
    scrolledUnderElevation: 0,
    backgroundColor:KColors.transparent,
    surfaceTintColor:KColors.transparent,
    systemOverlayStyle: SystemUiOverlayStyle.light,
    iconTheme: IconThemeData(color: KColors.light, size: KSizes.iconLg),
    actionsIconTheme: IconThemeData(color: KColors.light, size: KSizes.iconLg),
    titleTextStyle: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600, color: KColors.white),
  );
}