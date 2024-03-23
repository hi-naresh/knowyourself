import 'package:flutter/material.dart';
import '/bindings/general_bindings.dart';
import 'routes.dart';
import 'package:get/get.dart';
import '../utils/theme/theme.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // AwesomeNotifications().setListeners(
    //   onActionReceivedMethod: NotificationController.onActionReceivedMethod,
    //   onNotificationDisplayedMethod: NotificationController.onNotificationDisplayedMethod,
    //   onDismissActionReceivedMethod: NotificationController.onDismissActionReceivedMethod,
    //   onNotificationCreatedMethod: NotificationController.onNotificationCreatedMethod,
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // Get.lazyPut(() => null);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Know Yourself',
      theme: KAppTheme.lightTheme,
      // darkTheme: KAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      // themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: KRoutes.getSplashRoute(),
      getPages: KRoutes.routes,
    );
  }
}