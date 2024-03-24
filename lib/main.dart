import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/utils/http/http_client.dart';
import 'package:workmanager/workmanager.dart';
import 'app.dart';
import 'data/repo/auth/auth_repo.dart';
import 'data/services/background_services/background_service.dart';
import 'firebase_options.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  //remove in production release Http Service
  disableHttpsCertificateVerification();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  ).then((FirebaseApp value) => Get.put(AuthRepo()));
  Workmanager().initialize(callbackDispatcher);
  runApp(const MyApp());
}
