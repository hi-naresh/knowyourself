import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../features/mySpace/choices/model/choice_model.dart';

class ChoiceRepo extends GetxController{
  final GetStorage _storage = GetStorage();
  final String _choicesKey = 'UserChoices';

  Future<void> saveChoice(ChoiceModel choice) async {
    // Retrieve existing choices and convert them into ChoiceModel list
    final existingChoicesJson = _storage.read<List<dynamic>>(_choicesKey) ?? [];
    List<ChoiceModel> existingChoices = existingChoicesJson
        .map((json) => ChoiceModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();

    // Add the new choice
    existingChoices.add(choice);

    // Convert all choices back to List<Map<String, dynamic>> for storage
    final choicesJson = existingChoices.map((choice) => choice.toJson()).toList();
    await _storage.write(_choicesKey, choicesJson);
  }

  Future<List<ChoiceModel>> fetchAllChoices() async {
    // Retrieve choices JSON from storage
    final choicesJson = _storage.read<List<dynamic>>(_choicesKey) ?? [];
    // Convert JSON to List<ChoiceModel>
    return choicesJson
        .map((json) => ChoiceModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();
  }

  Future<void> updateChoice(ChoiceModel updatedChoice) async {
    // Retrieve existing choices and convert them into ChoiceModel list
    final existingChoicesJson = _storage.read<List<dynamic>>(_choicesKey) ?? [];
    List<ChoiceModel> existingChoices = existingChoicesJson
        .map((json) => ChoiceModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();

    // Find the index of the choice to update
    final index = existingChoices.indexWhere((c) => c.id == updatedChoice.id);
    if (index != -1) {
      // Update the choice
      existingChoices[index] = updatedChoice;

      // Convert all choices back to List<Map<String, dynamic>> for storage
      final choicesJson = existingChoices.map((choice) => choice.toJson()).toList();
      await _storage.write(_choicesKey, choicesJson);
    }
  }

  Future<void> deleteChoice(String choiceId) async {
    // Retrieve existing choices and convert them into ChoiceModel list
    final existingChoicesJson = _storage.read<List<dynamic>>(_choicesKey) ?? [];
    List<ChoiceModel> existingChoices = existingChoicesJson
        .map((json) => ChoiceModel.fromJson(Map<String, dynamic>.from(json)))
        .toList();

    // Remove the choice with the given ID
    existingChoices.removeWhere((c) => c.id == choiceId);

    // Convert all choices back to List<Map<String, dynamic>> for storage
    final choicesJson = existingChoices.map((choice) => choice.toJson()).toList();
    await _storage.write(_choicesKey, choicesJson);
  }

}