// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/text_strings.dart';
// import '../../../utils/constants/sizes.dart';
//
// class ManifestationController extends GetxController {
//   var visionBoardItems = <String>[].obs;
//   final TextEditingController journalController = TextEditingController();
//   final TextEditingController visionBoardController = TextEditingController();
//   var dailyChallenge = "Complete a random act of kindness.".obs;
//   var progress = 0.obs;
//
//   void addVisionBoardItem() {
//     if (visionBoardController.text.isNotEmpty) {
//       visionBoardItems.add(visionBoardController.text);
//       visionBoardController.clear();
//     }
//   }
//
//   void addJournalEntry() {
//     if (journalController.text.isNotEmpty) {
//       // Add the journal entry to the list (not displayed in this simplified example)
//       journalController.clear();
//     }
//   }
//
//   void completeChallenge() {
//     progress.value += 1;
//     // Update the challenge to a new one
//     dailyChallenge.value = "Write down three things you are grateful for.";
//   }
// }
//
// class ManifestationScreen extends StatelessWidget {
//   const ManifestationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(ManifestationController());
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(KSizes.defaultSpace),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildVisionBoardSection(context, controller),
//               const SizedBox(height: KSizes.defaultSpace),
//               _buildManifestationJournalSection(context, controller),
//               const SizedBox(height: KSizes.defaultSpace),
//               _buildDailyChallengesSection(context, controller),
//               const SizedBox(height: KSizes.defaultSpace),
//               _buildProgressTrackerSection(context, controller),
//               const SizedBox(height: KSizes.defaultSpace*5),
//
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildInspirationalQuoteSection(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Inspirational Quote',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         const SizedBox(height: KSizes.spaceBtwItems),
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: kApp4.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             '“The only limit to our realization of tomorrow is our doubts of today.” - Franklin D. Roosevelt',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyLarge
//                 ?.copyWith(color: kApp4),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildVisionBoardSection(
//       BuildContext context, ManifestationController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Vision Board',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         const SizedBox(height: KSizes.spaceBtwItems),
//         TextFormField(
//           controller: controller.visionBoardController,
//           decoration: InputDecoration(
//             labelText: 'Add an image or text',
//             labelStyle: Theme.of(context).textTheme.labelMedium,
//           ),
//         ),
//         const SizedBox(height: KSizes.defaultSpace),
//         TextButton(
//           style: const ButtonStyle().copyWith(
//             minimumSize: MaterialStateProperty.all(const Size(150, 50)),
//             backgroundColor: MaterialStateProperty.all(kApp4),
//             foregroundColor: MaterialStateProperty.all(Colors.white),
//           ),
//           onPressed: controller.addVisionBoardItem,
//           child: Text(
//             'Add to Vision Board',
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                 color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//         const SizedBox(height: KSizes.defaultSpace),
//         Obx(
//               () => Wrap(
//             spacing: 8,
//             children: controller.visionBoardItems
//                 .map((item) => Chip(
//               label: Text(item),
//               onDeleted: () {
//                 controller.visionBoardItems.remove(item);
//               },
//             ))
//                 .toList(),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildManifestationJournalSection(
//       BuildContext context, ManifestationController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Manifestation Journal',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         const SizedBox(height: KSizes.spaceBtwItems),
//         TextFormField(
//           controller: controller.journalController,
//           decoration: InputDecoration(
//             labelText: 'Write your manifestation statement',
//             labelStyle: Theme.of(context).textTheme.labelMedium,
//           ),
//         ),
//         const SizedBox(height: KSizes.defaultSpace),
//         TextButton(
//           style: const ButtonStyle().copyWith(
//             minimumSize: MaterialStateProperty.all(const Size(150, 50)),
//             backgroundColor: MaterialStateProperty.all(kApp4),
//             foregroundColor: MaterialStateProperty.all(Colors.white),
//           ),
//           onPressed: controller.addJournalEntry,
//           child: Text(
//             'Add to Journal',
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                 color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildDailyChallengesSection(
//       BuildContext context, ManifestationController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Daily Challenges',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         const SizedBox(height: KSizes.spaceBtwItems),
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: kApp4.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Obx(
//                 () => Text(
//               controller.dailyChallenge.value,
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyLarge
//                   ?.copyWith(color: kApp4),
//             ),
//           ),
//         ),
//         const SizedBox(height: KSizes.defaultSpace),
//         TextButton(
//           style: const ButtonStyle().copyWith(
//             minimumSize: MaterialStateProperty.all(const Size(150, 50)),
//             backgroundColor: MaterialStateProperty.all(kApp4),
//             foregroundColor: MaterialStateProperty.all(Colors.white),
//           ),
//           onPressed: controller.completeChallenge,
//           child: Text(
//             'Complete Challenge',
//             style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                 color: Colors.white, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildProgressTrackerSection(
//       BuildContext context, ManifestationController controller) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Progress Tracker',
//           style: Theme.of(context).textTheme.headlineMedium,
//         ),
//         const SizedBox(height: KSizes.spaceBtwItems),
//         Container(
//           padding: const EdgeInsets.all(12),
//           decoration: BoxDecoration(
//             color: kApp4.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Obx(
//                 () => LinearProgressIndicator(
//               value: controller.progress.value / 10,
//               backgroundColor: kEmptyProgress,
//               color: kApp4,
//               minHeight: 10,
//             ),
//           ),
//         ),
//         const SizedBox(height: KSizes.defaultSpace),
//         Obx(
//               () => Text(
//             'Progress: ${controller.progress.value} / 10',
//             style: Theme.of(context)
//                 .textTheme
//                 .bodyLarge
//                 ?.copyWith(color: kApp4),
//           ),
//         ),
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/colors.dart';
import '../../../utils/constants/sizes.dart';

class ManifestationController extends GetxController {
  var visionBoardItems = <String>[].obs;
  final TextEditingController journalController = TextEditingController();
  final TextEditingController visionBoardController = TextEditingController();
  var dailyChallenge = "Complete a random act of kindness.".obs;
  var progress = 0.obs;
  var journalEntries = <String>[].obs;
  var completedChallenges = <String>[].obs;

  void addVisionBoardItem() {
    if (visionBoardController.text.isNotEmpty) {
      visionBoardItems.add(visionBoardController.text);
      visionBoardController.clear();
    }
  }

  void addJournalEntry() {
    if (journalController.text.isNotEmpty) {
      journalEntries.add(journalController.text);
      journalController.clear();
    }
  }

  void completeChallenge() {
    completedChallenges.add(dailyChallenge.value);
    progress.value += 1;
    // Update the challenge to a new one
    dailyChallenge.value = "Write down three things you are grateful for.";
  }
}

class ManifestationScreen extends StatelessWidget {
  const ManifestationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ManifestationController());

    return Scaffold(

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInspirationalQuoteSection(context),
              const SizedBox(height: KSizes.defaultSpace),
              _buildVisionBoardSection(context, controller),
              const SizedBox(height: KSizes.defaultSpace),
              _buildManifestationJournalSection(context, controller),
              const SizedBox(height: KSizes.defaultSpace),
              _buildDailyChallengesSection(context, controller),
              const SizedBox(height: KSizes.defaultSpace),
              _buildProgressTrackerSection(context, controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInspirationalQuoteSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Inspirational Quote',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: KSizes.spaceBtwItems),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kApp4.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '“The only limit to our realization of tomorrow is our doubts of today.” - Franklin D. Roosevelt',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: kApp4),
          ),
        ),
      ],
    );
  }

  Widget _buildVisionBoardSection(
      BuildContext context, ManifestationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Vision Board',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: KSizes.spaceBtwItems),
        TextFormField(
          controller: controller.visionBoardController,
          decoration: InputDecoration(
            labelText: 'Add an image or text',
            labelStyle: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        const SizedBox(height: KSizes.defaultSpace),
        TextButton(
          style: const ButtonStyle().copyWith(
            minimumSize: MaterialStateProperty.all(const Size(150, 50)),
            backgroundColor: MaterialStateProperty.all(kApp4),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: controller.addVisionBoardItem,
          child: Text(
            'Add to Vision Board',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: KSizes.defaultSpace),
        Obx(
              () => Wrap(
            spacing: 8,
            children: controller.visionBoardItems
                .map((item) => Chip(
              label: Text(item),
              onDeleted: () {
                controller.visionBoardItems.remove(item);
              },
            ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildManifestationJournalSection(
      BuildContext context, ManifestationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Manifestation Journal',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: KSizes.spaceBtwItems),
        TextFormField(
          controller: controller.journalController,
          decoration: InputDecoration(
            labelText: 'I am grateful for...',
            labelStyle: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        const SizedBox(height: KSizes.defaultSpace),
        TextButton(
          style: const ButtonStyle().copyWith(
            minimumSize: MaterialStateProperty.all(const Size(150, 50)),
            backgroundColor: MaterialStateProperty.all(kApp4),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: controller.addJournalEntry,
          child: Text(
            'Add to Journal',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: KSizes.defaultSpace),
        TextButton(
          style: const ButtonStyle().copyWith(
            minimumSize: MaterialStateProperty.all(const Size(150, 50)),
            backgroundColor: MaterialStateProperty.all(kApp3),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () => _showJournalEntries(context, controller),
          child: Text(
            'View Journal Entries',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _showJournalEntries(BuildContext context, ManifestationController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Obx(() => ListView(
            children: controller.journalEntries
                .map((entry) => ListTile(title: Text(entry)))
                .toList(),
          )),
        );
      },
    );
  }

  Widget _buildDailyChallengesSection(
      BuildContext context, ManifestationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Daily Challenges',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: KSizes.spaceBtwItems),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kApp4.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(
                () => Text(
              controller.dailyChallenge.value,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: kApp4),
            ),
          ),
        ),
        const SizedBox(height: KSizes.defaultSpace),
        TextButton(
          style: const ButtonStyle().copyWith(
            minimumSize: MaterialStateProperty.all(const Size(150, 50)),
            backgroundColor: MaterialStateProperty.all(kApp4),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: controller.completeChallenge,
          child: Text(
            'Complete Challenge',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: KSizes.defaultSpace),
        TextButton(
          style: const ButtonStyle().copyWith(
            minimumSize: MaterialStateProperty.all(const Size(150, 50)),
            backgroundColor: MaterialStateProperty.all(kApp3),
            foregroundColor: MaterialStateProperty.all(Colors.white),
          ),
          onPressed: () => _showCompletedChallenges(context, controller),
          child: Text(
            'View All Completed Challenges',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  void _showCompletedChallenges(BuildContext context, ManifestationController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Obx(() => ListView(
            children: controller.completedChallenges
                .map((challenge) => ListTile(title: Text(challenge)))
                .toList(),
          )),
        );
      },
    );
  }

  Widget _buildProgressTrackerSection(
      BuildContext context, ManifestationController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Progress Tracker',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: KSizes.spaceBtwItems),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: kApp4.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Obx(
                () => LinearProgressIndicator(
              value: controller.progress.value / 10,
              backgroundColor: kEmptyProgress,
              color: kApp4,
              minHeight: 10,
            ),
          ),
        ),
        const SizedBox(height: KSizes.defaultSpace),
        Obx(
              () => Text(
            'Progress: ${controller.progress.value} / 10',
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: kApp4),
          ),
        ),
      ],
    );
  }
}
