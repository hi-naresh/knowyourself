import 'package:flutter/material.dart';
import '/bindings/general_bindings.dart';
import 'data/repo/space/journal/journal_repo.dart';
import 'features/personalisation/controller/app_controller.dart';
import 'routes.dart';
import 'package:get/get.dart';
import '../utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(()=>JournalRepo());
    Get.lazyPut(() => AppStateController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Know Yourself',
      theme: KAppTheme.lightTheme,
      darkTheme: KAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      themeMode: AppStateController.instance.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      // themeMode: theme.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      initialRoute: KRoutes.getSplashRoute(),
      getPages: KRoutes.routes,
    );
  }
}