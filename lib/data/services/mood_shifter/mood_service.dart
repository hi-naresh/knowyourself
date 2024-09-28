import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:knowyourself/features/mySpace/mood/model/activity_info_model.dart';
import 'package:knowyourself/features/mySpace/mood/model/mood_model_input.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

class MoodShiftService extends GetxService {
  static MoodShiftService get instance => Get.find();
  // final String _primaryUrl = "https://mood-shift.onrender.com/activities";
  final String _primaryUrl = "https://cdb0b322-68b9-471f-8a0c-021586dc9b98-00-ihnwwmb3balc.sisko.replit.dev/activities";
  // final String _healthCheckUrl = "https://mood-shift.onrender.com/health";
  // final String _backupUrl = "https://cdb0b322-68b9-471f-8a0c-021586dc9b98-00-ihnwwmb3balc.sisko.replit.dev/activities";
  late String _apiUrl=_primaryUrl;

  @override
  void onReady() {
    super.onReady();
    _apiUrl = _primaryUrl;
  }

  // Future<void> checkHealth() async {
  //   try {
  //     final response = await http.get(Uri.parse(_healthCheckUrl)).timeout(const Duration(seconds: 3));
  //
  //     if (response.statusCode == 200) {
  //       print("Health check successful");
  //     } else {
  //       throw Exception('Error: ${response.statusCode} ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     print("Error during health check: $e");
  //     // KHelper.showSnackBar(KTexts.healthCheckError,KTexts.checkLater);
  //     throw Exception('Failed to check health');
  //   }
  // }

  Future<List<ActivityModel>> fetchActivities(MoodModel request, {bool isRetry = false}) async {
    try {
      // checkHealth();
      final response = await http.post(
        Uri.parse(_apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: request.toJson(),
      ).timeout(const Duration(seconds: 6));

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
        _apiUrl = _primaryUrl;
        return await fetchActivities(request, isRetry: true);
      } else {
        throw Exception(KTexts.fetchActivitiesError);
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
