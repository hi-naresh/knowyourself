import 'package:flutter/material.dart';
import '/bindings/general_bindings.dart';
import 'data/repo/space/journal/journal_repo.dart';
import 'features/mySpace/space_screen.dart';
import 'features/personalisation/controller/app_controller.dart';
import 'features/personalisation/controller/profile_setup_controller.dart';
import 'routes.dart';
import 'package:get/get.dart';
import '../utils/theme/theme.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => AppStateController(), fenix: true);
    Get.put(JournalRepo());
    final spaceController = Get.lazyPut(()=>MySpaceController(),fenix: true);
    //needs to be lazy loaded or corrected when no user logged in
    Get.put(ProfileSetupController());
    return GetMaterialApp(
      initialBinding: GeneralBindings(),
      debugShowCheckedModeBanner: false,
      title: 'Know Yourself',
      theme: KAppTheme.lightTheme,
      darkTheme: KAppTheme.darkTheme,
      themeMode: AppStateController.instance.isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
      initialRoute: KRoutes.getSplashRoute(),
      getPages: KRoutes.routes,
    );
  }
}