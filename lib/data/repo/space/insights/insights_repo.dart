import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class InsightsRepo extends GetxService {
  static InsightsRepo get instance => Get.find();
  final GetStorage _storage = GetStorage();
  final String _storageKey = 'analyzed_core_values';

  Future<Map<String, double>?> fetchAnalyzedCoreValues(String entryId) async {
    var coreValuesRaw = _storage.read(_storageKey);
    if (coreValuesRaw != null) {
      Map<String, dynamic> coreValuesMap = jsonDecode(coreValuesRaw);
      if (coreValuesMap.containsKey(entryId)) {
        return Map<String, double>.from(coreValuesMap[entryId]);
      }
    }
    return null;
  }

  Future<void> storeAnalyzedCoreValues(String entryId, Map<String, double> coreValues) async {
    var coreValuesRaw = _storage.read(_storageKey);
    Map<String, dynamic> coreValuesMap = {};
    if (coreValuesRaw != null) {
      coreValuesMap = jsonDecode(coreValuesRaw);
    }

    coreValuesMap[entryId] = coreValues;
    await _storage.write(_storageKey, jsonEncode(coreValuesMap));
  }

  void logAnalyzedData() {
    var coreValuesRaw = _storage.read(_storageKey);
    if (coreValuesRaw != null) {
      Map<String, dynamic> coreValuesMap = jsonDecode(coreValuesRaw);
      coreValuesMap.forEach((entryId, coreValues) {
        print("Entry ID: $entryId -> Core Values: $coreValues");
      });
    }
  }
}
