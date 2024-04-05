import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:knowyourself/data/helper_service/backup_service/remote/backup_remote.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class BackupService extends GetxService {
  static BackupService get instance => Get.find();

  final GetStorage _storage = GetStorage();
  final OnlineBackupService _onlineBackupService = Get.put(OnlineBackupService()); // Get OnlineBackupService instance

  // Method to export data to a file and share
  Future<String> exportData() async {
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
    final String filePath = '${directory.path}/backup-${KHelper.getFormattedDateString(DateTime.now())}.json';
    final File file = File(filePath);
    await file.writeAsString(serializedData);

    return filePath;
  }

  Future<void> localStore() async{
    final List<XFile> xFile = [XFile(await exportData())];
    Share.shareXFiles(xFile);
  }

  Future<void> remoteStore() async {

    String filePath = await exportData();
    // Use OnlineBackupService to upload the file
    await _onlineBackupService.uploadBackup(filePath);
    KHelper.showSnackBar("Successfully backed up", "Data has been saved online successfully.");
  }

  Future<void> _importDataFromMap(File file) async {
    try{
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
    } on FormatException catch (e){
      KHelper.showSnackBar("Data import error", "$e");
    }
  }

  Future<void> importRemoteData() async {
    // Use OnlineBackupService to download the latest backup file
    final String downloadedFilePath = await _onlineBackupService.downloadBackup();
    if (downloadedFilePath.isNotEmpty) {
      File file = File(downloadedFilePath);
      _importDataFromMap(file);
      KHelper.showSnackBar("Online Data Imported", "Your data has been successfully imported.");
      // Optionally delete the downloaded file after import
      await file.delete();
    }else{
      KHelper.showSnackBar("No data found", "You have not backed up any data online");
    }
  }

  Future<void> importData() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      _importDataFromMap( file);
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
