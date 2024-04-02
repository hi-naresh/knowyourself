import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/personalisation/controller/user_controller.dart';

import '../../../../data/repo/space/milestones/milestone_repo.dart';
import '../../../../utils/constants/enums.dart';
import '../model/milestone_model.dart';


class MilestoneController extends GetxController {
  final MilestoneRepo _milestoneRepo = Get.put(MilestoneRepo());

  // Observables
  var dailyMilestones = <MilestoneModel>[].obs;
  var weeklyMilestones = <MilestoneModel>[].obs;
  var monthlyMilestones = <MilestoneModel>[].obs;

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  // final Rx<Period> milestonePeriod = Period.daily.obs;
  //exclude year from period
  final Rx<Period> milestonePeriod = Period.daily.obs;
  // final completedTasks = 0.obs;
  // final totalTasks = 0.obs;


  @override
  void onInit() {
    super.onInit();
    fetchAllMilestones();
  }

  Future<void> fetchAllMilestones() async {
    dailyMilestones.value = await _milestoneRepo.fetchMilestones(Period.daily);
    weeklyMilestones.value = await _milestoneRepo.fetchMilestones(Period.weekly);
    monthlyMilestones.value = await _milestoneRepo.fetchMilestones(Period.monthly);
  }

  Future<void> addMilestone() async {
    final userId = UserController.instance.user.value.id!;
    final milestone = MilestoneModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: titleController.text,
      description: descriptionController.text,
      status: false,
      userId: userId,
      createdAt: DateTime.now(),
      dueDate: DateTime.now(),
      milestonePeriod: milestonePeriod.value,
    );
    await addOrUpdateMilestone(milestone);
  }

  Future<void> addOrUpdateMilestone(MilestoneModel milestone) async {
    await _milestoneRepo.saveOrUpdateMilestone(milestone);
    fetchAllMilestones(); // Refresh milestones after adding/updating
  }

  Future<void> completeMilestone(String id, Period period) async {
    List<MilestoneModel> milestones = [];
    switch (period) {
      case Period.daily:
        milestones = dailyMilestones.value;
        break;
      case Period.weekly:
        milestones = weeklyMilestones.value;
        break;
      case Period.monthly:
        milestones = monthlyMilestones.value;
        break;
    }
    final index = milestones.indexWhere((m) => m.id == id);
    if (index != -1) {
      final updatedMilestone = milestones[index].copyWith(status: true);
      await addOrUpdateMilestone(updatedMilestone);
    }
  }

  Future<void> deleteMilestone(String id, Period period) async {
    await _milestoneRepo.deleteMilestone(id, period);
    fetchAllMilestones(); // Refresh milestones after deletion
  }

  // Get the number of completed tasks for each period
  double getCompletedTasksCount(Period period) {
    switch (period) {
      case Period.daily:
        return dailyMilestones.where((m) => m.status).length.toDouble();
      case Period.weekly:
        return weeklyMilestones.where((m) => m.status).length.toDouble();
      case Period.monthly:
        return monthlyMilestones.where((m) => m.status).length.toDouble();
      default:
        return 0;
    }
  }

  int getUncompletedTasksCount( Period period) {
    switch (period) {
      case Period.daily:
        return dailyMilestones.where((m) => !m.status).length;
      case Period.weekly:
        return weeklyMilestones.where((m) => !m.status).length;
      case Period.monthly:
        return monthlyMilestones.where((m) => !m.status).length;
      default:
        return 0;
    }
  }

  getMilestonesByPeriod(Period period) {
    switch (period) {
      case Period.daily:
        return dailyMilestones;
      case Period.weekly:
        return weeklyMilestones;
      case Period.monthly:
        return monthlyMilestones;
      default:
        return [];
    }
  }

  double getProgress(Period period) {
    final totalTasks = getMilestonesByPeriod(period).length;
    final completedTasks = getCompletedTasksCount(period);
    return totalTasks == 0 ? 0 : completedTasks / totalTasks;
  }

  void undoCompleteMilestone(id, Period period) {
    List<MilestoneModel> milestones = [];
    switch (period) {
      case Period.daily:
        milestones = dailyMilestones.value;
        break;
      case Period.weekly:
        milestones = weeklyMilestones.value;
        break;
      case Period.monthly:
        milestones = monthlyMilestones.value;
        break;
    }
    final index = milestones.indexWhere((m) => m.id == id);
    if (index != -1) {
      final updatedMilestone = milestones[index].copyWith(status: false);
      addOrUpdateMilestone(updatedMilestone);
    }
  }

}
