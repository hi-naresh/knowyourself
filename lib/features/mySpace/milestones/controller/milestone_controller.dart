import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/personalisation/controller/user_controller.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../../data/repo/space/milestones/milestone_repo.dart';
import '../../../../utils/constants/enums.dart';
import '../model/milestone_model.dart';

class MilestoneController extends GetxController {
  static MilestoneController instance = Get.find();
  final MilestoneRepo _milestoneRepo = Get.put(MilestoneRepo());

  // Observables
  var dailyMilestones = <MilestoneModel>[].obs;
  var weeklyMilestones = <MilestoneModel>[].obs;
  var monthlyMilestones = <MilestoneModel>[].obs;

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  final Rx<Period> milestonePeriod = Period.daily.obs;

  @override
  void onReady() {
    super.onReady();
    fetchAllMilestones();
    _milestoneRepo.milestonesUpdated.listen((_) {
      fetchAllMilestones();
    });
  }

  void fetchAllMilestones() async {
    var allMilestones = await _milestoneRepo.fetchAllMilestones();
    dailyMilestones.assignAll(allMilestones.where((m) => m.milestonePeriod == Period.daily));
    weeklyMilestones.assignAll(allMilestones.where((m) => m.milestonePeriod == Period.weekly));
    monthlyMilestones.assignAll(allMilestones.where((m) => m.milestonePeriod == Period.monthly));
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
    titleController.clear();
    descriptionController.clear();
    Get.back();
    KHelper.showSnackBar("Milestone added successfully","success");
  }

  //add demo milestones data
  // Future<void> addDemoMilestones() async {
  //   final userId = UserController.instance.user.value.id!;
  //   final demoMilestones = [
  //     MilestoneModel(
  //       id: DateTime.now().millisecondsSinceEpoch.toString(),
  //       title: "Read a book",
  //       description: "Read a book for 30 minutes",
  //       status: false,
  //       userId: userId,
  //       createdAt: DateTime.now(),
  //       dueDate: DateTime.now(),
  //       milestonePeriod: Period.daily,
  //     ),
  //   ];
  //   for (var milestone in demoMilestones) {
  //     await addOrUpdateMilestone(milestone);
  //   }
  // }

  Future<void> addOrUpdateMilestone(MilestoneModel milestone) async {
    await _milestoneRepo.saveOrUpdateMilestone(milestone);
    fetchAllMilestones(); // Refresh milestones after adding/updating
  }

  Future<void> completeMilestone(String id, Period period) async {
    List<MilestoneModel> milestones = getMilestonesByPeriod(period);
    final index = milestones.indexWhere((m) => m.id == id);
    if (index != -1) {
      final updatedMilestone = milestones[index].copyWith(status: true);
      await addOrUpdateMilestone(updatedMilestone);
      // _showNotification("Task Completed", "Congratulations! You have completed a task.");
    }
  }

  Future<void> deleteMilestone(String id, Period period) async {
    await _milestoneRepo.deleteMilestone(id, period);
    fetchAllMilestones(); // Refresh milestones after deletion
  }

  int getCompletedTasksCount(Period period) {
    switch (period) {
      case Period.daily:
        return dailyMilestones.where((m) => m.status).length;
      case Period.weekly:
        return weeklyMilestones.where((m) => m.status).length;
      case Period.monthly:
        return monthlyMilestones.where((m) => m.status).length;
      default:
        return 0;
    }
  }

  int getUncompletedTasksCount(Period period) {
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

  int getTotalTasksCount(Period period) {
    switch (period) {
      case Period.daily:
        return dailyMilestones.length;
      case Period.weekly:
        return weeklyMilestones.length;
      case Period.monthly:
        return monthlyMilestones.length;
      default:
        return 0;
    }
  }

  List<MilestoneModel> getMilestonesByPeriod(Period period) {
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
    List<MilestoneModel> milestones = getMilestonesByPeriod(period);
    final index = milestones.indexWhere((m) => m.id == id);
    if (index != -1) {
      final updatedMilestone = milestones[index].copyWith(status: false);
      addOrUpdateMilestone(updatedMilestone);
    }
  }

}
