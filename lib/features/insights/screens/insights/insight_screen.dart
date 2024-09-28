// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:knowyourself/features/insights/screens/insights/widgets/reflection_chart.dart';
// import 'package:knowyourself/utils/constants/colors.dart';
// import 'package:knowyourself/utils/constants/sizes.dart';
//
// import '../../../../utils/constants/enums.dart';
// import '../../../../utils/constants/text_strings.dart';
// import '../../../../utils/helpers/helper_functions.dart';
// import '../../../learning/screens/learn_screen/widgets/progress_bar.dart';
// import '../../../mySpace/journal/model/journal_model.dart';
// import '../../../mySpace/milestones/controller/milestone_controller.dart';
// import '../../controller/insights_controller.dart';
// import 'widgets/progress_milestones.dart';
//
// class InsightScreen extends StatelessWidget {
//   const InsightScreen({super.key});
//
//   Widget coreValueWidget(BuildContext context, String name, double percentage,
//       List<JournalEntry> entries) {
//     return ExpansionTile(
//       title: Text(name.capitalizeFirst!,
//           style: Theme.of(context).textTheme.titleMedium),
//       trailing: Container(
//         height: 40,
//         width: 40,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: KColors.valueColors[CoreValues.values
//               .firstWhere((e) => e.toString().split('.').last == name)],
//         ),
//         child: Center(
//           child: Text(
//             '${percentage.toInt()}%',
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//         ),
//       ),
//       //add header for entries with date and impact only first line
//       children: entries
//           .map((entry) => coreValueDetailWidget(
//                 context,
//                 KHelper.getFormattedDate(entry.entryDate),
//                 entry.coreValues[name] ?? 0.0,
//               ))
//           .toList(),
//     );
//   }
//
//   Widget coreValueDetailWidget(
//       BuildContext context, String date, double impact) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: KSizes.md, vertical: KSizes.xs),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(date, style: Theme.of(context).textTheme.bodyMedium),
//           Text('${(impact).toPrecision(2)}%',
//               style: Theme.of(context).textTheme.bodySmall),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(InsightsController());
//     final milesController = MilestoneController.instance;
//     return SingleChildScrollView(
//       child: Center(
//           child: Padding(
//         padding: const EdgeInsets.all(KSizes.defaultSpace),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               KTexts.insightsHead,
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             const SizedBox(height: KSizes.sm),
//             Text(
//               KTexts.insightSubtitle,
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//             const SizedBox(height: KSizes.md),
//             ProgressComponent(
//               milestonesProgress: {
//                 KTexts.daily: milesController.getCompletedTasksCount(Period.daily)/milesController.getTotalTasksCount(Period.daily),
//                 KTexts.weekly: milesController.getCompletedTasksCount(Period.weekly)/milesController.getTotalTasksCount(Period.weekly),
//                 KTexts.monthly: milesController.getCompletedTasksCount(Period.monthly)/milesController.getTotalTasksCount(Period.monthly),
//               },
//             ),
//             // ElevatedButton(onPressed: ()=>controller.mlAnalyze(), child: Text('Test')),
//             const SizedBox(height: KSizes.defaultSpace),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Text(
//                   KTexts.insightsHead2,
//                   style: Theme.of(context).textTheme.headlineSmall,
//                 ),
//                 IconButton(
//                     onPressed: () => controller.calculateInsights(),
//                     icon: const Icon(CupertinoIcons.wand_stars_inverse)),
//               ],
//             ),
//             const SizedBox(height: KSizes.sm),
//             Text(
//               KTexts.insightSubtitle2,
//               style: Theme.of(context).textTheme.bodySmall,
//             ),
//             const SizedBox(height: KSizes.defaultSpace),
//             const Center(child: ReflectionChart()),
//             const SizedBox(height: KSizes.defaultSpace),
//             Obx(() => Column(
//                   children: [
//                     Center(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             KTexts.coreValuesTitle,
//                             style: Theme.of(context).textTheme.titleMedium,
//                           ),
//                           FilledButton(
//                             child: Text(controller.showCoreValues.value
//                                 ? KTexts.hideAllButtonText
//                                 : KTexts.showAllButtonText ),
//                             onPressed: () => controller.showCoreValues.value =
//                                 !controller.showCoreValues.value,
//                           ),
//                         ],
//                       ),
//                     ),
//                     if (controller.showCoreValues.value)
//                       if (controller.journalEntries.isEmpty)
//                         const Text(KTexts.noEntriesFoundMessage)
//                       else
//                         Column(
//                           children: controller.analyzedCoreValues
//                               .map((e) => coreValueWidget(
//                                     context,
//                                     e.name,
//                                     e.percentage.toPrecision(2),
//                                     controller.journalEntries
//                                         .where((entry) => entry.coreValues
//                                             .containsKey(e.name))
//                                         .toList(),
//                                   ))
//                               .toList(),
//                         ),
//                     if (controller.showCoreValues.value)
//                       const SizedBox(height: KSizes.defaultSpace),
//                   ],
//                 )),
//             // Obx(
//             //       () => Visibility(
//             //     visible: controller.showCoreValues.isTrue,
//             //     child: Column(
//             //       children: controller.analyzedCoreValues.map((coreValue) {
//             //         final entriesWithImpact = controller.journalEntries
//             //             .where((entry) => entry.coreValues[coreValue.name] != null)
//             //             .toList();
//             //
//             //         return coreValueWidget(
//             //           context,
//             //           coreValue.name,
//             //           coreValue.percentage,
//             //           entriesWithImpact,
//             //         );
//             //       }).toList(),
//             //     ),
//             //   ),
//             // ),
//             const SizedBox(height: KSizes.defaultSpace),
//             Text(
//               KTexts.learnHead2,
//               style: Theme.of(context).textTheme.headlineMedium,
//             ),
//             const SizedBox(height: KSizes.defaultSpace),
//             const LearningProgressBars(
//               learningAspectsProgress: {
//                 KTexts.mental: 0.65, // 75%
//                 KTexts.physical: 0.5, // 50%
//                 KTexts.emotional: 0.7, // 90%
//                 KTexts.spiritual: 0.6, // 60%
//               },
//             ),
//             const SizedBox(height: KSizes.defaultSpace * 6),
//             // CustomPlaceHolder("Consistency Record", 50.h, double.infinity),
//             // SizedBox(height: 20.h),
//             // CustomPlaceHolder("Activity Suggestion", 80.h, double.infinity),
//             // SizedBox(height: 80.h),
//           ],
//         ),
//       )),
//     );
//   }
// }

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:knowyourself/features/insights/screens/insights/widgets/reflection_chart.dart';
// import 'package:knowyourself/utils/constants/colors.dart';
// import 'package:knowyourself/utils/constants/sizes.dart';
//
// import '../../../../utils/constants/enums.dart';
// import '../../../../utils/constants/text_strings.dart';
// import '../../../../utils/helpers/helper_functions.dart';
// import '../../../learning/screens/learn_screen/widgets/progress_bar.dart';
// import '../../../mySpace/journal/model/journal_model.dart';
// import '../../../mySpace/milestones/controller/milestone_controller.dart';
// import '../../controller/insights_controller.dart';
// import 'widgets/progress_milestones.dart';
//
// class InsightScreen extends StatelessWidget {
//   const InsightScreen({super.key});
//
//   Widget coreValueWidget(BuildContext context, String name, double percentage,
//       List<JournalEntry> entries) {
//     return ExpansionTile(
//       title: Text(name.capitalizeFirst!,
//           style: Theme.of(context).textTheme.titleMedium),
//       trailing: Container(
//         height: 40,
//         width: 40,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: KColors.valueColors[CoreValues.values
//               .firstWhere((e) => e.toString().split('.').last == name)],
//         ),
//         child: Center(
//           child: Text(
//             '${percentage.toInt()}%',
//             style: Theme.of(context).textTheme.bodyLarge,
//           ),
//         ),
//       ),
//       // Add header for entries with date and impact only first line
//       children: entries
//           .map((entry) => coreValueDetailWidget(
//         context,
//         KHelper.getFormattedDate(entry.entryDate),
//         entry.coreValues[name] ?? 0.0,
//       ))
//           .toList(),
//     );
//   }
//
//   Widget coreValueDetailWidget(
//       BuildContext context, String date, double impact) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(
//           horizontal: KSizes.md, vertical: KSizes.xs),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(date, style: Theme.of(context).textTheme.bodyMedium),
//           Text('${(impact).toPrecision(2)}%',
//               style: Theme.of(context).textTheme.bodySmall),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(InsightsController());
//     final milesController = MilestoneController.instance;
//
//     return SingleChildScrollView(
//       child: Center(
//         child: Padding(
//           padding: const EdgeInsets.all(KSizes.defaultSpace),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 KTexts.insightsHead,
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//               const SizedBox(height: KSizes.sm),
//               Text(
//                 KTexts.insightSubtitle,
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//               const SizedBox(height: KSizes.md),
//               ProgressComponent(
//                 milestonesProgress: {
//                   KTexts.daily: milesController.getCompletedTasksCount(Period.daily) /
//                       milesController.getTotalTasksCount(Period.daily),
//                   KTexts.weekly: milesController.getCompletedTasksCount(Period.weekly) /
//                       milesController.getTotalTasksCount(Period.weekly),
//                   KTexts.monthly: milesController.getCompletedTasksCount(Period.monthly) /
//                       milesController.getTotalTasksCount(Period.monthly),
//                 },
//               ),
//               const SizedBox(height: KSizes.defaultSpace),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     KTexts.insightsHead2,
//                     style: Theme.of(context).textTheme.headlineSmall,
//                   ),
//                   IconButton(
//                       onPressed: () => {},
//                       icon: const Icon(CupertinoIcons.wand_stars_inverse)),
//                 ],
//               ),
//               const SizedBox(height: KSizes.sm),
//               Text(
//                 KTexts.insightSubtitle2,
//                 style: Theme.of(context).textTheme.bodySmall,
//               ),
//               const SizedBox(height: KSizes.defaultSpace),
//               const Center(child: ReflectionChart()),  // Updated ReflectionChart
//               const SizedBox(height: KSizes.defaultSpace),
//               Obx(() => Column(
//                 children: [
//                   Center(
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           KTexts.coreValuesTitle,
//                           style: Theme.of(context).textTheme.titleMedium,
//                         ),
//                         FilledButton(
//                           child: Text(controller.showCoreValues.value
//                               ? KTexts.hideAllButtonText
//                               : KTexts.showAllButtonText),
//                           onPressed: () => controller.showCoreValues.value =
//                           !controller.showCoreValues.value,
//                         ),
//                       ],
//                     ),
//                   ),
//                   if (controller.showCoreValues.value)
//                     if (controller.journalEntries.isEmpty)
//                       const Text(KTexts.noEntriesFoundMessage)
//                     else
//                       Column(
//                         children: controller.analyzedCoreValues
//                             .map((e) => coreValueWidget(
//                           context,
//                           e.name,
//                           e.percentage.toPrecision(2),
//                           controller.journalEntries
//                               .where((entry) => entry.coreValues
//                               .containsKey(e.name))
//                               .toList(),
//                         ))
//                             .toList(),
//                       ),
//                   if (controller.showCoreValues.value)
//                     const SizedBox(height: KSizes.defaultSpace),
//                 ],
//               )),
//               const SizedBox(height: KSizes.defaultSpace),
//               Text(
//                 KTexts.learnHead2,
//                 style: Theme.of(context).textTheme.headlineMedium,
//               ),
//               const SizedBox(height: KSizes.defaultSpace),
//               const LearningProgressBars(
//                 learningAspectsProgress: {
//                   KTexts.mental: 0.65, // 75%
//                   KTexts.physical: 0.5, // 50%
//                   KTexts.emotional: 0.7, // 90%
//                   KTexts.spiritual: 0.6, // 60%
//                 },
//               ),
//               const SizedBox(height: KSizes.defaultSpace * 6),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/insights/screens/insights/widgets/reflection_chart.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../utils/constants/enums.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';
import '../../../learning/screens/learn_screen/widgets/progress_bar.dart';
import '../../../mySpace/journal/model/journal_model.dart';
import '../../../mySpace/milestones/controller/milestone_controller.dart';
import '../../controller/insights_controller.dart';
import 'widgets/progress_milestones.dart';

class InsightScreen extends StatelessWidget {
  const InsightScreen({super.key});

  Widget coreValueWidget(BuildContext context, String name, double percentage,
      List<JournalEntry> entries) {
    return ExpansionTile(
      title: Text(name.capitalizeFirst!,
          style: Theme.of(context).textTheme.titleMedium),
      trailing: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: KColors.valueColors[CoreValues.values
              .firstWhere((e) => e.toString().split('.').last == name)],
        ),
        child: Center(
          child: Text(
            '${percentage.toInt()}%',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
      // Add header for entries with date and impact only first line
      children: entries
          .map((entry) => coreValueDetailWidget(
        context,
        KHelper.getFormattedDate(entry.entryDate),
        entry.coreValues[name] ?? 0.0,
      ))
          .toList(),
    );
  }

  Widget coreValueDetailWidget(
      BuildContext context, String date, double impact) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: KSizes.md, vertical: KSizes.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(date, style: Theme.of(context).textTheme.bodyMedium),
          Text('${(impact).toPrecision(2)}%',
              style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(InsightsController(), permanent: true);
    final milesController = MilestoneController.instance;

    return Obx(
        ()=> SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(KSizes.defaultSpace),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  KTexts.insightsHead,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: KSizes.sm),
                Text(
                  KTexts.insightSubtitle,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: KSizes.md),
                ProgressComponent(
                  milestonesProgress: {
                    KTexts.daily: milesController.getCompletedTasksCount(Period.daily) /
                        milesController.getTotalTasksCount(Period.daily),
                    KTexts.weekly: milesController.getCompletedTasksCount(Period.weekly) /
                        milesController.getTotalTasksCount(Period.weekly),
                    KTexts.monthly: milesController.getCompletedTasksCount(Period.monthly) /
                        milesController.getTotalTasksCount(Period.monthly),
                  },
                ),
                const SizedBox(height: KSizes.defaultSpace),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      KTexts.insightsHead2,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    IconButton(
                        onPressed: () => controller.loadAndAnalyzeJournalEntries(),
                        icon: const Icon(CupertinoIcons.wand_stars_inverse)),
                  ],
                ),
                const SizedBox(height: KSizes.sm),
                Text(
                  KTexts.insightSubtitle2,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: KSizes.defaultSpace),
                const Center(child: ReflectionChart()),  // Updated ReflectionChart
                const SizedBox(height: KSizes.defaultSpace),
                Obx(() => Column(
                  children: [
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            KTexts.coreValuesTitle,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          FilledButton(
                            child: Text(controller.showCoreValues.value
                                ? KTexts.hideAllButtonText
                                : KTexts.showAllButtonText),
                            onPressed: () => controller.showCoreValues.value =
                            !controller.showCoreValues.value,
                          ),
                        ],
                      ),
                    ),
                    if (controller.showCoreValues.value)
                      if (controller.journalEntries.isNotEmpty)
                        Column(
                    children: controller.analyzedCoreValues
                        .map((e) => coreValueWidget(
                  context,
                  e.name,
                  e.percentage.toPrecision(2),
                  controller.journalEntries
                      .where((entry) => entry.coreValues
                      .containsKey(e.name))
                      .toList(),
                ))
                    .toList(),
                )
                      else
                        const Text(KTexts.noEntriesFoundMessage),
                    if (controller.showCoreValues.value)
                      const SizedBox(height: KSizes.defaultSpace),
                  ],
                )),
                const SizedBox(height: KSizes.defaultSpace),
                Text(
                  KTexts.learnHead2,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: KSizes.defaultSpace),
                const LearningProgressBars(
                  learningAspectsProgress: {
                    KTexts.mental: 0.65, // 75%
                    KTexts.physical: 0.5, // 50%
                    KTexts.emotional: 0.7, // 90%
                    KTexts.spiritual: 0.6, // 60%
                  },
                ),
                const SizedBox(height: KSizes.defaultSpace * 6),
              ],
            ),
          ),
        ),
      ),
    );

  }
}
