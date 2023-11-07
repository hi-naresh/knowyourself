import 'package:url_launcher/url_launcher.dart';

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}

extension DaysInMonthExtension on DateTime {
  int get daysInMonth {
    return DateTime(year, month + 1, 1)
        .difference(DateTime(year, month, 1))
        .inDays;
  }
}

String? _encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
          '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

Future<void> sendMail() async {
  final Uri emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'contact@KYB.com',
    query: _encodeQueryParameters(<String, String>{
      'subject': 'Feedback For KYB',
    }),
  );

  launchUrl(emailLaunchUri);
}

Future<void> openPlayStore() async {
  String playStoreLink =
      "https://google.com";

  final uri = Uri.parse(playStoreLink);
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
    return;
  }
}
