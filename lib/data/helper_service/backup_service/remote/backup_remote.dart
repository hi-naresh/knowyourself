import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:knowyourself/features/personalisation/controller/user_controller.dart';
import 'package:path_provider/path_provider.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../../../../utils/helpers/helper_functions.dart';

class OnlineBackupService extends GetxService {
  static OnlineBackupService get instance => Get.find();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // Method to upload backup to Firebase Storage
  Future<void> uploadBackup(String filePath) async {
    File file = File(filePath);
    try {
      final userId = UserController.instance.user.value.id!;
      String fileName = "backup-${KHelper.getFormattedDateString(DateTime.now())}.json";
      await _storage.ref('$userId/$fileName').putFile(file);
      // Optionally, delete previous backups if required.
    } catch (e) {
      KHelper.showSnackBar("Error uploading backup", "$e");
    }
  }

  Future<String> downloadBackup() async {
    try {
      final userId = UserController.instance.user.value.id!;
      // List all files and find the latest backup
      final ListResult result = await _storage.ref(userId).listAll();
      final List<Reference> allFiles = result.items;
      // Assuming the last file is the latest backup
      if (allFiles.isNotEmpty) {
        final String downloadURL = await allFiles.last.getDownloadURL();
        // Download the file content from the URL
        final http.Response response = await http.get(Uri.parse(downloadURL));
        if (response.statusCode == 200) {
          // Save the downloaded content locally
          final Directory directory = await getApplicationDocumentsDirectory();
          final downloadPath = '${directory.path}/backup-${KHelper.getFormattedDateString(DateTime.now())}.json';
          final File downloadFile = File(downloadPath);
          await downloadFile.writeAsBytes(response.bodyBytes);
          return downloadPath;
        } else {
          KHelper.showSnackBar("Failed to download data", "${response.statusCode}");
        }
      }
    } catch (e) {
      KHelper.showSnackBar("Error downloading backup", "$e");
    }
    return "";
  }

}
