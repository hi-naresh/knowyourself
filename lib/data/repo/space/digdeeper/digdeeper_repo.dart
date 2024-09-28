import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../../features/mySpace/digdeeper/model/deeper.dart';

class DigDeeperRepo extends GetxController {
  final GetStorage _storage = GetStorage();
  final String _digDeeperKey = 'UserDigDeeper';

  // Save a new DigDeeper entry
  Future<void> saveDigDeeperEntry(DigDeeperModel entry) async {
    // Retrieve existing entries and convert them into DigDeeperModel list
    final existingEntriesJson = _storage.read<List<dynamic>>(_digDeeperKey) ?? [];

    // Safely map the entries and filter out any null or invalid entries
    List<DigDeeperModel> existingEntries = existingEntriesJson
        .where((json) => json != null && json is Map<String, dynamic>)
        .map((json) => DigDeeperModel.fromJson(json as Map<String, dynamic>))
        .toList();

    // Add the new entry
    existingEntries.add(entry);

    // Convert all entries back to List<Map<String, dynamic>> for storage
    final entriesJson = existingEntries.map((entry) => entry.toJson()).toList();
    await _storage.write(_digDeeperKey, entriesJson);
  }

  // Fetch all stored DigDeeper entries
  Future<List<DigDeeperModel>> fetchAllEntries() async {
    final entriesJson = _storage.read<List<dynamic>>(_digDeeperKey) ?? [];

    // Ensure each entry is non-null and properly formatted
    return entriesJson
        .where((json) => json != null && json is Map<String, dynamic>)
        .map((json) => DigDeeperModel.fromJson(json as Map<String, dynamic>))
        .toList();
  }

  // Update an existing DigDeeper entry
  Future<void> updateDigDeeperEntry(DigDeeperModel updatedEntry) async {
    final existingEntriesJson = _storage.read<List<dynamic>>(_digDeeperKey) ?? [];
    List<DigDeeperModel> existingEntries = existingEntriesJson
        .where((json) => json != null && json is Map<String, dynamic>)
        .map((json) => DigDeeperModel.fromJson(json as Map<String, dynamic>))
        .toList();

    final index = existingEntries.indexWhere((entry) => entry.incidentId == updatedEntry.incidentId);
    if (index != -1) {
      existingEntries[index] = updatedEntry;

      final entriesJson = existingEntries.map((entry) => entry.toJson()).toList();
      await _storage.write(_digDeeperKey, entriesJson);
    }
  }

  // Delete a DigDeeper entry by ID
  Future<void> deleteDigDeeperEntry(String entryId) async {
    final existingEntriesJson = _storage.read<List<dynamic>>(_digDeeperKey) ?? [];
    List<DigDeeperModel> existingEntries = existingEntriesJson
        .where((json) => json != null && json is Map<String, dynamic>)
        .map((json) => DigDeeperModel.fromJson(json as Map<String, dynamic>))
        .toList();

    existingEntries.removeWhere((entry) => entry.incidentId == entryId);

    final entriesJson = existingEntries.map((entry) => entry.toJson()).toList();
    await _storage.write(_digDeeperKey, entriesJson);
  }
}
