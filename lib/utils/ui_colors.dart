import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/provider/App%20State/app_state_provider.dart';

//
const Color kJournalLightCardColor = Color(0xFFFFFFFF);
const Color kJournalDarkCardColor = Color(0xFF3C3C56);
const Color kJournalDarkPrimaryColor = Color(0xFF111116);
const Color kJournalLightPrimaryColor = Color(0xFFFFD9E9);
const Color kJournalPrimaryColor = Color(0xFF016EEA);
const Color kFABDarkColor = Color(0xFF111116);
const Color kFABLightColor = Color(0xFFFFD9E9);
const Color kCalendarLightContainerColor = Color(0xFFE6E6EA);
const Color kCalendarDarkContainerColor = Color(0xFF323248);
const Color kJournalWidgetCardLightColor = Color(0xFFE6E6EB);
const Color kJournalWidgetCardDarkColor = Color(0xFF323248);

const Color kDarkModeButtonColor = Color(0xFF3C3C56);
const Color kLightModeButtonColor = Color(0xFFE7E5FD);

Color getJournalCardColor(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return kDarkModeTextFieldColor;
  }
  return kJournalLightCardColor;
}

Color getJournalPrimaryColor(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return kJournalDarkPrimaryColor;
  }
  return kJournalLightPrimaryColor;
}

Color getFABColor(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return kFABDarkColor;
  }
  return kFABLightColor;
}

Color getCalendarColor(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return kCalendarDarkContainerColor;
  }
  return kJournalWidgetCardLightColor;
}

Color getJournalWidgetCardColor(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return kJournalWidgetCardDarkColor;
  }
  return kJournalWidgetCardLightColor;
}

// Todo

// Home

// Settings
const Color kSettingsLightCardColor = Color(0xFFE1E1E9);
const Color kSettingsDarkCardColor = Color(0x000000ff);

// App
const Color kLightModeScaffoldColor = Color(0xFFFFFFFF);
const Color kDarkModeScaffoldColor = Color(0xff232330);

const Color kPrimaryColor =kApp1;
const Color kBackground =  Color(0xFFFFECEC);
const Color kBackground1 = Color(0xFFF5F5F5);
const Color kBackground2 = Color(0xFFFBFBFB);
const Color kBottomNav = Color(0xFFFFFFFF);

const Color kSecondaryColor = Color(0xFFD2C6FF);
const Color kPrimaryTextColor = Colors.black;
const Color kSecondaryTextColor = Color(0xFF8E8E8E);
const Color kLightModeTextFieldColor = Color(0xFFE6E6EA);

const Color kApp2 = kPie1;
const Color kApp3 = kPie2;
const Color kApp3_1 = Color(0xFFD9FFED);
const Color kApp1 = kPie;
const Color kApp4 = Color(0xFFFFB999);
const Color kGreyed = Color(0xFFBEBEBE);
const Color kGreyed1 = Color(0xFF363538);
const Color kShadow = Color(0xFFE8E8E8);

const Color kNewP1 = Color(0xFFD7E6FE);
const Color kNewP1_1 = Color(0xFFBFDAFF);
const Color kNewP2 = Color(0xFFFFEAE7);
const Color kNewP2_1 = Color(0xFFFFCCBF);
const Color kBoxLight = Color(0xFFF4F3F1);

const Color kPie = Color(0xFFAEBFFF);
const Color kPie1 = Color(0xFFFF98BF);
const Color kPie2 = Color(0xFF63D5AC);
const Color kPieBox = Color(0xFFEEF6FF);
const Color kPieBox1 = Color(0xFFDAE1EA);
const Color kProgress = Color(0xFFE9EDF1);

//core values
const Color kCoreValue1 = Color(0xFFEF7C00);
const Color kCoreValue1_1 = Color(0xFFFAC6A1);
const Color kCoreValue2 = Color(0xFFEFB500);
const Color kCoreValue2_1 = Color(0xFFF3E1AA);
const Color kCoreValue3 = Color(0xFFF8D600);
const Color kCoreValue3_1 = Color(0xFFFCEA9E);
const Color kCoreValue4 = Color(0xFFB9D900);
const Color kCoreValue4_1 = Color(0xFFE3F3A5);
const Color kCoreValue5 = Color(0xFF00AE1B);
const Color kCoreValue5_1 = Color(0xFFA3E6B4);
const Color kCoreValue6 = Color(0xFF007530);
const Color kCoreValue6_1 = Color(0xFF78D59E);
const Color kCoreValue7 = Color(0xFF005CA5);
const Color kCoreValue7_1 = Color(0xFF7AB9E6);
const Color kCoreValue8 = Color(0xFF1C3385);
const Color kCoreValue8_1 = Color(0xFF49AAEF);
const Color kCoreValue9 = Color(0xFF692A81);
const Color kCoreValue9_1 = Color(0xFFA17DE6);
const Color kCoreValue10 = Color(0xFFBC037B);
const Color kCoreValue10_1 = Color(0xFFE07FBC);
const Color kCoreValue11 = Color(0xFFF0025E);
const Color kCoreValue11_1 = Color(0xFFF676A6);
const Color kCoreValue12 = Color(0xFFEC0012);
const Color kCoreValue12_1 = Color(0xFFEF7272);




const Color kDarkText = Color(0xFF371B34);
const Color kLightText = Color(0xFF696969);

Decoration decorationGrad = const BoxDecoration(
  gradient: LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFF7CCC5),
      Color(0xFFFFA497),
    ],
  ),
  borderRadius: BorderRadius.all(Radius.circular(20)),
);

// Color(0xFFFF5D9C)
// Color(0xFF19C788)
// Color(0xFF0086DF)
// Color(0xFF191D21)
const Color kPalette1 = Color(0xFFFF5D9C);
const Color kPalette2 = Color(0xFF19C788);
const Color kPalette3 = Color(0xFF0086DF);
const Color kPalette4 = Color(0xFF191D21);
const Color kWhite = Color(0xFFFAF7F7);

const Color kPalette5 = Color(0xFF343434);
const Color kSelectedDate = Color(0xFFF5B293);

const Color kPalette6 = Color(0xFFFBFBFB);
const Color kPalette6_1 = Color(0xFFEAE9E8);
const Color kPalette6_2 = Color(0xFFAAB8EA);

const Color kDarkModeCardColor = Color(0xff3C3C56);

const Color kLightModeCardColor = Colors.white;
const Color kDarkModeTextFieldColor = Color(0xFF3C3C56);
const Color kLightModeBottomNavBarColor = Colors.white;
const Color kDarkModeBottomNavBarColor = Color(0xFF3C3C56);
const Color kCalendarPrimaryColor = Color(0xFFFF4D98);
const Color kCalendarSecondaryColor = Color(0xfff0f0f4);
const Color kTodoPrimaryColor = Color(0xFF19C788);
const Color kHomePrimaryColor = Color(0xFF6A61F1);
const Color kAccountPrimaryColor = Color(0xFF6A61F1);

Color? getColorbyTheme(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return kDarkModeScaffoldColor;
  }
  return kLightModeScaffoldColor;
}

Color? getBottomNavBarColorbyTheme(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return kDarkModeBottomNavBarColor;
  }
  return kLightModeBottomNavBarColor;
}

Color? getTextColorbyTheme(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return Colors.white;
  }
  return kPrimaryTextColor;
}

Color? getTextFieldColorbyTheme(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return kDarkModeTextFieldColor;
  }
  return kLightModeTextFieldColor;
}

Brightness getSystemNavBarBrightness(BuildContext context) {
  if (Provider.of<AppStateProvider>(context, listen: false).isDarkMode) {
    return Brightness.light;
  }
  return Brightness.dark;
}
