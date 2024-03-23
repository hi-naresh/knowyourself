import 'package:flutter/material.dart';
import '/bindings/general_bindings.dart';
import 'features/personalisation/controller/app_controller.dart';
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
    // CustomShadow.disableShadows = KHelper.isDarkMode(context);
    final appController = Get.put(AppStateController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Know Yourself',
      theme: KAppTheme.lightTheme,
      darkTheme: KAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      themeMode: appController.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      // themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: KRoutes.getSplashRoute(),
      getPages: KRoutes.routes,
    );
  }
}