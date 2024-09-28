import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/utils/http/http_client.dart';
import 'package:workmanager/workmanager.dart';
import 'app.dart';
import 'data/helper_service/notifications/notification_service.dart';
import 'data/repo/auth/auth_repo.dart';
import 'data/helper_service/background_scheduler/background_service.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await dotenv.load(fileName: ".env");
  //remove in production release Http Service
  disableHttpsCertificateVerification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthRepo()));
  // runApp(const MyApp());
  // Initialize WorkManager
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  // Initialize Notification Service
  // await Get.putAsync(() => NotificationService().init());
  // Initialize Workmanager
  // BackgroundService.initialize();
// Initialize Workmanager and Notification Service
//   BackgroundService.initialize();
  await Get.putAsync(() => NotificationService().init());

  // Initialize Notification Service
  // await Get.putAsync(() => NotificationService().onInit());

  final runnableApp = _buildRunnableApp(
    isWeb: kIsWeb,
    webAppWidth:double.infinity,
    app: const MyApp(),
  );
  runApp(runnableApp);
}

Widget _buildRunnableApp({
  required bool isWeb,
  required double webAppWidth,
  required Widget app,
}) {
  if (!isWeb) {
    return app;
  }

  return Center(
    child: ClipRect(
      child: SizedBox(
        width: webAppWidth,
        child: app,
      ),
    ),
  );
}