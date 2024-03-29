import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../repo/space/journal/journal_repo.dart';

class BackupService extends GetxService {
  static BackupService get instance => Get.find();

  final JournalRepo _journalRepo = Get.find();

  // Method to export data to a file and share
  Future<void> exportData() async {
    final List<dynamic> journalEntries = await _journalRepo.exportJournalEntries();
    // Fetch data from other repositories as needed

    final Map<String, dynamic> exportData = {
      'journalEntries': journalEntries,
      // Include other data as needed
    };

    final String serializedData = jsonEncode(exportData);

    final Directory directory = await getApplicationDocumentsDirectory();
    final File file = File('${directory.path}/backup.json');
    await file.writeAsString(serializedData);

    final List<XFile> xFile = [XFile(file.path)];

    Share.shareXFiles(xFile);
  }

  Future<void> importData() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String content = await file.readAsString();
      Map<String, dynamic> importData = jsonDecode(content);

      if (importData.containsKey('journalEntries')) {
        await _journalRepo.importJournalEntries(importData['journalEntries']);
        // Import data into other repositories as needed
      }

      // Notify user of successful import or handle errors
    } else {
      // User canceled the picker
    }
  }

  void eraseData() {
    final storage = GetStorage();
    try {
      storage.erase();
      KHelper.showSnackBar("Deleted All Data", "My Space has been cleaned up.");
    } catch (e) {
      print('Error erasing data: $e');
    }
  }
}
