import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:knowyourself/models/Quote/quote_model.dart';
import 'package:knowyourself/models/To%20Do/status_model.dart';
import 'package:knowyourself/models/To%20Do/to_do_model.dart';

// ignore: avoid_classes_with_only_static_members
class SharedPreferencesHelper {
  static SharedPreferences? preferences;

  static Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  static void saveHasOnboarded(bool canAuth) {
    int permissionIndex = 0;
    if (canAuth == true) {
      permissionIndex = 1;
    }
    preferences!.setInt("hasonboarded", permissionIndex);
  }

  static bool hasOnboarded() {
    final index = preferences!.getInt("hasonboarded");

    if (index == null) {
      return false;
    }

    return index == 1 ? true : false;
  }

  static Future<void> saveUserName({required String name}) async {
    await preferences?.setString("alias", name);
  }

  static String getUserName() {
    String? userName = preferences!.getString("alias");
    if (userName == null) {
      return "";
    }
    return userName;
  }

  static Future<void> saveAvatar({required String avatar}) async {
    await preferences?.setString("avatar", avatar);
  }

  static String getAvatar() {
    String? avatar = preferences!.getString("avatar");
    if (avatar == null) {
      return "avatar1";
    }
    return avatar;
  }

  static Future<void> saveQuote({required QuoteModel quoteModel}) async {
    await preferences?.setString(
        DateFormat.yMEd().format(DateTime.now()), jsonEncode(quoteModel));
  }

  static QuoteModel? getQuote() {
    String? quoteString = preferences!.getString(
      DateFormat.yMEd().format(DateTime.now()),
    );
    if (quoteString != null) {
      try {
        QuoteModel quoteModel =
            QuoteModel.fromMap(jsonDecode(jsonDecode(quoteString)));
        return quoteModel;
      } catch (e) {
        return null;
      }
    }

    return null;
  }

  static Future<void> saveCelebration({required String celebration}) async {
    await preferences?.setString(
        DateFormat.yMMMMd().format(DateTime.now()), celebration);
  }

  static String getCelebration({required DateTime dateTime}) {
    String? celebration = preferences!.getString(
      DateFormat.yMMMMd().format(dateTime),
    );
    if (celebration == null) {
      return "";
    }
    return celebration;
  }

  static Future<void> saveToDoList({required List<ToDoModel> todos}) async {
    List<String> todoList = [];
    for (ToDoModel task in todos) {
      todoList.add(jsonEncode(task));
    }
    await preferences?.setStringList(
        DateFormat.yMd().format(DateTime.now()), todoList);
  }

  static List<ToDoModel> getTodoList({required DateTime dateTime}) {
    List<ToDoModel> tasks = [];
    final taskMap = preferences!.getStringList(
      DateFormat.yMd().format(dateTime),
    );

    if (taskMap == null) {
      return tasks;
    }

    for (String task in taskMap) {
      tasks.add(
        ToDoModel.fromMap(jsonDecode(jsonDecode(task)) as Map<String, dynamic>),
      );
    }
    return tasks;
  }

  static void saveTheme(bool isDark) {
    int themeIndex = 0;
    if (isDark == true) {
      themeIndex = 1;
    }
    preferences!.setInt("themeindex", themeIndex);
  }

  static int getSavedTheme() {
    final index = preferences!.getInt("themeindex");

    if (index == null) {
      return 0;
    }

    return index;
  }

  static void saveScores(int point) {
    int points = getPoints();
    preferences!.setInt("points", point + points);
  }

  static int getPoints() {
    final scores = preferences!.getInt("points");

    if (scores == null) {
      return 0;
    }

    return scores;
  }

  static void saveAuthPermission(bool canAuth) {
    int permissionIndex = 0;
    if (canAuth == true) {
      permissionIndex = 1;
    }
    preferences!.setInt("authpermission", permissionIndex);
  }

  static void saveReminderNotificationPermission(bool canNotify) {
    int permissionIndex = 0;
    if (canNotify == true) {
      permissionIndex = 1;
    }
    preferences!.setInt("notifypermission", permissionIndex);
  }

  static void saveNotificationTime(Duration duration) {
    List<String> time = [
      duration.inHours.toString(),
      duration.inMinutes.remainder(60).toString()
    ];

    preferences!.setStringList("notifytime", time);
  }

  static Duration getNotificationTime() {
    List<String>? time = preferences!.getStringList("notifytime");
    if (time == null) {
      return const Duration(hours: 20, minutes: 00);
    }

    return Duration(hours: int.parse(time[0]), minutes: int.parse(time[1]));
  }

  static bool getReminderNotificationPermission() {
    final index = preferences!.getInt("notifypermission");

    if (index == null) {
      return false;
    }

    return index == 1 ? true : false;
  }

  static void saveNotificationPermission(bool canNotify) {
    int permissionIndex = 0;
    if (canNotify == true) {
      permissionIndex = 1;
    }
    preferences!.setInt("notification", permissionIndex);
  }

  static bool getNotificationPermission() {
    final index = preferences!.getInt("notification");

    if (index == null) {
      return false;
    }

    return index == 1 ? true : false;
  }

  static bool getAuthPermission() {
    final index = preferences!.getInt("authpermission");

    if (index == null) {
      return false;
    }

    return index == 1 ? true : false;
  }

  static void saveStatus(StatusModel story) async {
    List<String> statusList = preferences!.getStringList("status") ?? [];

    statusList.add(jsonEncode(story));

    await preferences?.setStringList("status", statusList);
  }

  static List<StatusModel> getStatus({required DateTime dateTime}) {
    List<StatusModel> status = [];
    final statusMap = preferences!.getStringList(
      "status",
    );

    if (statusMap == null) {
      return status;
    }

    for (String story in statusMap) {
      status.add(
        StatusModel.fromMap(
            jsonDecode(jsonDecode(story)) as Map<String, dynamic>),
      );
    }
    return status;
  }

  static void deleteStatus() async {
    await preferences!.remove("status");
  }

  static void saveDate(DateTime date) async {
    final String dateNow = DateFormat('dd-MM-yyyy').format(date);
    preferences!.setString("currentDate", dateNow);
  }

  static String getDate() {
    final String? date = preferences!.getString("currentDate");
    if (date == null) {
      SharedPreferencesHelper.saveDate(DateTime.now());
      return DateFormat('dd-MM-yyyy').format(DateTime.now());
    }
    return date;
  }
}
