import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/helpers/helper_functions.dart';
import '../../controller/milestone_controller.dart';

class MilestoneProgressList extends StatelessWidget {
  final Period period;

  const MilestoneProgressList({
    super.key,
    required this.period,
  });

  @override
  Widget build(BuildContext context) {
    final MilestoneController controller = Get.put(MilestoneController());

    return Container(
      padding: const EdgeInsets.symmetric(horizontal:  KSizes.defaultSpace/2, vertical: KSizes.xs),
      decoration: BoxDecoration(
        color: KHelper.isDarkMode(context) ? KColors.kEmptyProgressDark : KColors.kEmptyProgress,
        borderRadius: const BorderRadius.all(Radius.circular(KSizes.borderRadiusLgx)),
      ),
      child: Obx(
          (){
            final title = '${period.name.capitalizeFirst}';
            final tasksCount = controller.getTotalTasksCount(period);
            final completedTasksCount = controller.getCompletedTasksCount(period);
            final double progress = controller.getProgress(period);
            return Column(
              children: [
                ListTile(
                  title: Text(title, style: Theme.of(context).textTheme.headlineSmall),
                  subtitle: Text('${KTexts.completed} $completedTasksCount/$tasksCount ${KTexts.milestones}.'),
                ),
                LinearProgressIndicator(
                  value: progress,
                  borderRadius: BorderRadius.circular(KSizes.borderRadiusLgx),
                  valueColor: const AlwaysStoppedAnimation<Color>(KColors.kApp4),
                ),
                ExpansionTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(KSizes.borderRadiusLg),
                  ),
                  title: Text(KTexts.tasks, style: Theme.of(context).textTheme.bodyMedium),
                  collapsedIconColor: KColors.kApp4,
                  iconColor: KColors.kApp4,
                  children: [
                    ListView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: controller.getMilestonesByPeriod(period).length,
                      itemBuilder: (BuildContext context, int index) {
                        final milestone = controller.getMilestonesByPeriod(period)[index];
                        return CheckboxListTile(
                          value: milestone.status,
                          title: Text(milestone.title),
                          activeColor: KColors.kApp4,
                          checkboxShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(KSizes.borderRadiusLg),
                          ),
                          secondary: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(CupertinoIcons.reply_thick_solid),
                                onPressed: () {
                                  controller.undoCompleteMilestone(milestone.id, period);
                                },
                              ),
                              IconButton(
                                icon: const Icon(CupertinoIcons.delete),
                                onPressed: () {
                                  controller.deleteMilestone(milestone.id, period);
                                },
                              ),
                            ],
                          ),
                          onChanged: (bool? checked) {
                            controller.completeMilestone(milestone.id, period);
                          },
                          controlAffinity: ListTileControlAffinity.leading, // To align checkbox to the left
                        );
                      },
                    )
                  ],
                ),
              ],
            );
          },
      ),
    );
  }
}
