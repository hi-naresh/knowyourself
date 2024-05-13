import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:knowyourself/features/mySpace/mood/model/activity_info_model.dart';
import 'package:knowyourself/features/mySpace/mood/model/mood_model_input.dart';

class MoodShiftService extends GetxService {
  static MoodShiftService get instance => Get.find();
  final String _primaryUrl = "https://mood-shift.onrender.com/activitiess";
  final String _backupUrl = "https://cdb0b322-68b9-471f-8a0c-021586dc9b98-00-ihnwwmb3balc.sisko.replit.dev/activities";
  late String _apiUrl;

  @override
  void onInit() {
    super.onInit();
    _apiUrl = _primaryUrl;
  }

  Future<List<ActivityModel>> fetchActivities(MoodModel request, {bool isRetry = false}) async {
    try {
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: request.toJson(),
      ).timeout(const Duration(seconds: 3));

      if (response.statusCode == 200) {
        final jsonResponse = response.body;
        final List<ActivityModel> activities = (jsonDecode(jsonResponse)['activities'] as List)
            .map((item) => ActivityModel.fromJson(item))
            .toList();
        return activities;
      } else {
        throw Exception('Error: ${response.statusCode} ${response.reasonPhrase}');
      }
    } catch (e) {
      print("Error during fetchActivities: $e");

      if (!isRetry) { // Retry with backup URL if not already retrying
        _apiUrl = _backupUrl;
        return await fetchActivities(request, isRetry: true);
      } else {
        throw Exception('Failed to load activities after retrying');
      }
    } finally {
      _apiUrl = _primaryUrl;
    }
  }

  @override
  void onClose() {
    super.onClose();
    _apiUrl = _primaryUrl;
  }
}
