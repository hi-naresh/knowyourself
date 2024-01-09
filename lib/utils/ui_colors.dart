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

const Color kPrimaryColor = Color(0xFFFF5D9C);
const Color kBackground =  Color(0xFFFFE0F7);
const Color kSecondaryColor = Color(0xFFD2C6FF);
const Color kPrimaryTextColor = Colors.black;
const Color kSecondaryTextColor = Color(0xFF8E8E8E);
const Color kLightModeTextFieldColor = Color(0xFFE6E6EA);


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
