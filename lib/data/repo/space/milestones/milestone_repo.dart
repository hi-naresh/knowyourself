import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../features/mySpace/milestones/model/milestone_model.dart';
import '../../../../utils/constants/enums.dart';

class MilestoneRepo extends GetxController {

  static MilestoneRepo get instance => Get.find();
  final GetStorage _storage = GetStorage();
  static const _dailyMilestoneKey = 'dailyMilestones';
  static const _weeklyMilestoneKey = 'weeklyMilestones';
  static const _monthlyMilestoneKey = 'monthlyMilestones';

  final milestonesUpdated = false.obs;

  // Save or update a milestone
  Future<void> saveOrUpdateMilestone(MilestoneModel milestone) async {
    final key = _getKeyForPeriod(milestone.milestonePeriod);
    final milestones = await fetchMilestones(milestone.milestonePeriod);
    final index = milestones.indexWhere((m) => m.id == milestone.id);
    if (index == -1) {
      milestones.add(milestone);
    } else {
      milestones[index] = milestone;
    }
    await _storage.write(key, milestones.map((m) => m.toJson()).toList());
    milestonesUpdated.value = !milestonesUpdated.value;
  }

  // Fetch all milestones for a given period
  Future<List<MilestoneModel>> fetchMilestones(Period period) async {
    final key = _getKeyForPeriod(period);
    final milestoneJsonList = _storage.read<List<dynamic>>(key) ?? [];
    return milestoneJsonList.map((json) => MilestoneModel.fromJson(json)).toList();
  }

  //fetch all without period
  Future<List<MilestoneModel>> fetchAllMilestones() async {
    final dailyMilestones = await fetchMilestones(Period.daily);
    final weeklyMilestones = await fetchMilestones(Period.weekly);
    final monthlyMilestones = await fetchMilestones(Period.monthly);
    return [...dailyMilestones, ...weeklyMilestones, ...monthlyMilestones];
  }

  // Delete a milestone
  Future<void> deleteMilestone(String id, Period period) async {
    final key = _getKeyForPeriod(period);
    final milestones = await fetchMilestones(period);
    milestones.removeWhere((m) => m.id == id);
    await _storage.write(key, milestones.map((m) => m.toJson()).toList());
    milestonesUpdated.value = !milestonesUpdated.value;
  }

  // Helper to determine the correct storage key based on the milestone period
  String _getKeyForPeriod(Period period) {
    switch (period) {
      case Period.daily:
        return _dailyMilestoneKey;
      case Period.weekly:
        return _weeklyMilestoneKey;
      case Period.monthly:
        return _monthlyMilestoneKey;
      default:
        throw ArgumentError('Invalid milestone period');
    }
  }
}
