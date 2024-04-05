import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import '../../repo/space/journal/journal_repo.dart';

// class BackupService extends GetxService {
//   static BackupService get instance => Get.find();
//
//   final JournalRepo _journalRepo = Get.find();
//
//   // Method to export data to a file and share
//   Future<void> exportData() async {
//     // Fetch data from other repositories as needed
//     // Example keys to fetch data from GetStorage:
//
//     final storage = GetStorage();
//     var entries = storage.read('journalEntries');
//     final journalEntries = Future.value(entries.map((e) => e.toString()).toList());
//     final List questions = storage.read('questions');
//     // flutter: Key: journalEntries
//     // flutter: Key: questions
//     // flutter: Key: currentStory
//     // flutter: Key: desiredStory
//     // flutter: Key: dailyMilestones
//     // flutter: Key: weeklyMilestones
//
//     final Map<String, dynamic> exportData = {
//       'journalEntries': journalEntries,
//       'questions': questions,
//       // Include other data as needed
//     };
//
//     final String serializedData = jsonEncode(exportData);
//
//     final Directory directory = await getApplicationDocumentsDirectory();
//     final File file = File('${directory.path}/backup.json');
//     await file.writeAsString(serializedData);
//
//     final List<XFile> xFile = [XFile(file.path)];
//
//     Share.shareXFiles(xFile);
//   }
//
//   Future<void> importData() async {
//     FilePickerResult? result = await FilePicker.platform.pickFiles();
//
//     if (result != null) {
//       File file = File(result.files.single.path!);
//       String content = await file.readAsString();
//       Map<String, dynamic> importData = jsonDecode(content);
//
//       if (importData.containsKey('journalEntries')) {
//         await _journalRepo.importJournalEntries(importData['journalEntries']);
//         // Import data into other repositories as needed
//       }
//
//       // Notify user of successful import or handle errors
//       KHelper.showSnackBar("Data Imported", "Your data has been successfully imported.");
//     } else {
//       // User canceled the picker
//       KHelper.showSnackBar("Import Canceled", "You did not select a file to import.");
//     }
//   }
//
//   void eraseData() {
//     final storage = GetStorage();
//     try {
//       storage.remove('journalEntries');
//       KHelper.showSnackBar("Deleted All Data", "My Space has been cleaned up.");
//     } catch (e) {
//       print('Error erasing data: $e');
//     }
//   }
//
// }

class BackupService extends GetxService {
  static BackupService get instance => Get.find();

  final GetStorage _storage = GetStorage();

  // Method to export data to a file and share
  Future<void> exportData() async {
    Map<String, dynamic> exportData = {
      'journalEntries': _storage.read('journalEntries') ?? [],
      'questions': _storage.read('questions') ?? [],
      'currentStory': _storage.read('currentStory') ?? '',
      'desiredStory': _storage.read('desiredStory') ?? '',
      'dailyMilestones': _storage.read('dailyMilestones') ?? [],
      'weeklyMilestones': _storage.read('weeklyMilestones') ?? [],
      'monthlyMilestones': _storage.read('monthlyMilestones') ?? [],
    };

    String serializedData = jsonEncode(exportData);
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/backup.json';
    final File file = File(filePath);
    await file.writeAsString(serializedData);

    final List<XFile> xFile = [XFile(file.path)];

    Share.shareXFiles(xFile);

  }

  // Method to import data from a file
  Future<void> importData() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File file = File(result.files.single.path!);
      String content = await file.readAsString();
      Map<String, dynamic> importData = jsonDecode(content);

      // Deserialize and save data to GetStorage for each key
      _storage.write('journalEntries', importData['journalEntries']);
      _storage.write('questions', importData['questions']);
      _storage.write('currentStory', importData['currentStory']);
      _storage.write('desiredStory', importData['desiredStory']);
      _storage.write('dailyMilestones', importData['dailyMilestones']);
      _storage.write('weeklyMilestones', importData['weeklyMilestones']);
      _storage.write('monthlyMilestones', importData['monthlyMilestones']);
      // Handle other keys similarly

      KHelper.showSnackBar("Data Imported", "Your data has been successfully imported.");
    } else {
      KHelper.showSnackBar("Import Canceled", "You did not select a file to import.");
    }
  }

  // Method to erase all user data
  void eraseData() {
    try {
      _storage.erase();
      KHelper.showSnackBar("Deleted All Data", "All data has been erased.");
    } catch (e) {
      KHelper.showSnackBar("Error Deleting Data", "An error occurred while deleting data.");
    }
  }
}
