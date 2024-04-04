import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/personalisation/controller/user_controller.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

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
  final Rx<Period> milestonePeriod = Period.daily.obs;

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
    List<MilestoneModel> milestones = getMilestonesByPeriod(period);
    final index = milestones.indexWhere((m) => m.id == id);
    if (index != -1) {
      final updatedMilestone = milestones[index].copyWith(status: true);
      await addOrUpdateMilestone(updatedMilestone);
      _showNotification("Task Completed", "Congratulations! You have completed a task.");
    }
  }

  Future<void> deleteMilestone(String id, Period period) async {
    await _milestoneRepo.deleteMilestone(id, period);
    fetchAllMilestones(); // Refresh milestones after deletion
  }

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

  Future<void> _showNotification(String title, String body) async {
    int notificationId = DateTime.now().millisecondsSinceEpoch & 0xFFFFFFFF; // Generate a valid 32-bit size integer ID
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: notificationId,
        channelKey: 'basic_channel',
        title: title,
        body: body,
      ),
    );
  }
}
