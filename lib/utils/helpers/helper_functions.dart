import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../constants/colors.dart';
import '../constants/sizes.dart';

class KHelper {
  KHelper._();

  static void showSnackBar(String title, String message) {
    Get.snackbar(
      title, message,
      // backgroundGradient: KColors.accentPrimaryGradient,
      backgroundColor: KColors.primary,
      barBlur: 0,
      colorText: KColors.white,
      // boxShadows: KColors.defaultShadow,
      isDismissible: true,
      borderRadius: KSizes.borderRadiusXl,
      margin: const EdgeInsets.symmetric(horizontal:  KSizes.defaultSpace/1.3),
    );
  }

  static void showBottomSheet(Widget child) {
    Get.bottomSheet(
      child,
      backgroundColor: Theme.of(Get.context!).scaffoldBackgroundColor,
      isDismissible: true,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(KSizes.borderRadiusXl),
          topRight: Radius.circular(KSizes.borderRadiusXl),
        ),
      ),
    );
  }
  static void showAlert(String title, String message) {
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  static String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  static bool isDarkMode(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  //isDarkMode without context
  static bool isDark() {
    return Get.isDarkMode;
  }

  static Size screenSize() {
    return MediaQuery.of(Get.context!).size;
  }

  static double screenHeight() {
    return MediaQuery.of(Get.context!).size.height;
  }

  static double screenWidth() {
    return MediaQuery.of(Get.context!).size.width;
  }

  static String getFormattedDate(DateTime date, {String format = 'dd MMM yyyy'}) {
    return DateFormat(format).format(date);
  }

  static List<T> removeDuplicates<T>(List<T> list) {
    return list.toSet().toList();
  }

  String? _encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((MapEntry<String, String> e) =>
    '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  // Future<void> sendMail() async {
  //   final Uri emailLaunchUri = Uri(
  //     scheme: 'mailto',
  //     path: 'contact@KYB.com',
  //     query: _encodeQueryParameters(<String, String>{
  //       'subject': 'Feedback For KYB',
  //     }),
  //   );
  //
  //   launchUrl(emailLaunchUri);
  // }

  // Future<void> openPlayStore() async {
  //   String playStoreLink =
  //       "https://google.com";
  //
  //   final uri = Uri.parse(playStoreLink);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(
  //       uri,
  //       mode: LaunchMode.externalApplication,
  //     );
  //     return;
  //   }
  // }

  static Future<void> launchUrl(String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url, mode: LaunchMode.inAppWebView);
    }
  }

  // static Future<void> openUrl(String url) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launch(url);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }

  static List<Widget> wrapWidgets(List<Widget> widgets, int rowSize) {
    final wrappedList = <Widget>[];
    for (var i = 0; i < widgets.length; i += rowSize) {
      final rowChildren = widgets.sublist(i, i + rowSize > widgets.length ? widgets.length : i + rowSize);
      wrappedList.add(Row(children: rowChildren));
    }
    return wrappedList;
  }
}

extension DaysInMonthExtension on DateTime {
  int get daysInMonth {
    return DateTime(year, month + 1, 1)
        .difference(DateTime(year, month, 1))
        .inDays;
  }
}