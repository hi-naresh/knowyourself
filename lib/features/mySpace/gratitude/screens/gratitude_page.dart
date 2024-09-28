// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../utils/constants/colors.dart';
// import '../../../../utils/constants/sizes.dart';
// import '../../../../utils/constants/text_strings.dart';
// import '../../../../utils/helpers/helper_functions.dart';
//
// class GratitudeAffirmationController extends GetxController {
//   var gratitudeItems = <String>[].obs;
//   var affirmationItems = <String>[].obs;
//   final TextEditingController gratitudeController = TextEditingController();
//   final TextEditingController affirmationController = TextEditingController();
//
//   void addGratitude() {
//     if (gratitudeController.text.isNotEmpty) {
//       gratitudeItems.add(gratitudeController.text);
//       gratitudeController.clear();
//     }
//   }
//
//   void addAffirmation() {
//     if (affirmationController.text.isNotEmpty) {
//       affirmationItems.add(affirmationController.text);
//       affirmationController.clear();
//     }
//   }
//
//   void deleteGratitude(int index) {
//     gratitudeItems.removeAt(index);
//   }
//
//   void deleteAffirmation(int index) {
//     affirmationItems.removeAt(index);
//   }
// }
//
// class GratitudeAffirmationScreen extends StatelessWidget {
//   const GratitudeAffirmationScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(GratitudeAffirmationController());
//
//     return Scaffold(
//       body: SingleChildScrollView(
//         child: SizedBox(
//           height: Get.height,
//           child: Column(
//             children: [
//               _buildAddSection(
//                 context,
//                 controller,
//                 'Gratitude',
//                 controller.gratitudeController,
//                 controller.addGratitude,
//               ),
//               _buildListSection(
//                 context,
//                 'Gratitude List',
//                 controller.gratitudeItems,
//                 controller.deleteGratitude,
//               ),
//               _buildAddSection(
//                 context,
//                 controller,
//                 'Affirmation',
//                 controller.affirmationController,
//                 controller.addAffirmation,
//               ),
//               _buildListSection(
//                 context,
//                 'Affirmation List',
//                 controller.affirmationItems,
//                 controller.deleteAffirmation,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildAddSection(
//       BuildContext context,
//       GratitudeAffirmationController controller,
//       String title,
//       TextEditingController textController,
//       VoidCallback onAdd,
//       ) {
//     return Padding(
//       padding: const EdgeInsets.all(KSizes.defaultSpace),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text.rich(
//             TextSpan(
//               children: [
//                 TextSpan(
//                   text: 'Add ',
//                   style: Theme.of(context).textTheme.headlineMedium,
//                 ),
//                 TextSpan(
//                   text: title,
//                   style: Theme.of(context)
//                       .textTheme
//                       .headlineMedium
//                       ?.copyWith(color: kApp4),
//                 ),
//               ],
//             ),
//           ),
//           const SizedBox(height: KSizes.spaceBtwItems),
//           Text(
//             'Enter your $title below',
//             style: Theme.of(context).textTheme.bodySmall,
//           ),
//           const SizedBox(height: KSizes.defaultSpace),
//           TextFormField(
//             controller: textController,
//             decoration: InputDecoration(
//               labelText: 'Enter $title',
//               labelStyle: Theme.of(context).textTheme.labelMedium,
//             ),
//           ),
//           const SizedBox(height: KSizes.defaultSpace),
//           TextButton(
//             style: const ButtonStyle().copyWith(
//               minimumSize:
//               MaterialStateProperty.all(const Size(double.infinity, 50)),
//               backgroundColor: MaterialStateProperty.all(kApp4),
//               foregroundColor: MaterialStateProperty.all(Colors.white),
//             ),
//             onPressed: onAdd,
//             child: Text(
//               'Add $title',
//               style: Theme.of(context)
//                   .textTheme
//                   .bodyLarge
//                   ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildListSection(
//       BuildContext context,
//       String title,
//       RxList<String> items,
//       Function(int) onDelete,
//       ) {
//     return Expanded(
//       child: Obx(
//             () => ListView.builder(
//           padding: const EdgeInsets.all(KSizes.md),
//           itemCount: items.length,
//           itemBuilder: (context, index) {
//             return ListTile(
//               splashColor: Colors.transparent,
//               title: Text(items[index]),
//               trailing: IconButton(
//                 icon: const Icon(CupertinoIcons.minus_circle_fill,
//                     color: kApp4),
//                 onPressed: () => onDelete(index),
//               ),
//               onTap: () {},
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class GratitudeAffirmationController extends GetxController {
  var gratitudeItems = <String>[].obs;
  final TextEditingController gratitudeController = TextEditingController();
  var showPrevious = false.obs;

  void addGratitude() {
    if (gratitudeController.text.isNotEmpty) {
      gratitudeItems.add('I am grateful for ${gratitudeController.text}');
      gratitudeController.clear();
    }
  }

  void deleteGratitude(int index) {
    gratitudeItems.removeAt(index);
  }

  void toggleShowPrevious() {
    showPrevious.value = !showPrevious.value;
  }
}

class GratitudeAffirmationScreen extends StatelessWidget {
  const GratitudeAffirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GratitudeAffirmationController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAddGratitudeSection(context, controller),
              const SizedBox(height: KSizes.defaultSpace),
              _buildPracticeAffirmationsSection(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAddGratitudeSection(
      BuildContext context,
      GratitudeAffirmationController controller,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Add ',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextSpan(
                text: 'Gratitude',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: KColors.kApp4),
              ),
            ],
          ),
        ),
        const SizedBox(height: KSizes.spaceBtwItems),
        Text(
          'Enter your gratitude below',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: KSizes.defaultSpace),
        _buildGratitudeSuggestions(),
        const SizedBox(height: KSizes.defaultSpace),
        TextFormField(
          controller: controller.gratitudeController,
          decoration: InputDecoration(
            labelText: 'I am grateful for ...',
            labelStyle: Theme.of(context).textTheme.labelMedium,
          ),
        ),
        const SizedBox(height: KSizes.defaultSpace),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              style: const ButtonStyle().copyWith(
                minimumSize: MaterialStateProperty.all(const Size(150, 50)),
                backgroundColor: MaterialStateProperty.all(KColors.kApp4),
                foregroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: controller.addGratitude,
              child: Text(
                'Add Gratitude',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ),
            TextButton(
              onPressed: () => _showGratitudeList(context, controller),
              child: Text('View Previous'),
            ),
          ],
        ),
      ],
    );
  }

  void _showGratitudeList(
      BuildContext context, GratitudeAffirmationController controller) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Gratitude List',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: KSizes.spaceBtwItems),
              Obx(
                    () => ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.gratitudeItems.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(controller.gratitudeItems[index]),
                      trailing: IconButton(
                        icon: const Icon(CupertinoIcons.minus_circle_fill,
                            color: KColors.kApp4),
                        onPressed: () => controller.deleteGratitude(index),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildGratitudeSuggestions() {
    final suggestions = [
      'Family',
      'Friends',
      'Good Health',
      'A Beautiful Sunset',
      'A Compliment Received',
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Suggestions for Being Grateful:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: KSizes.spaceBtwItems),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 8,
            children: suggestions
                .map((suggestion) => Chip(
              label: Text(suggestion),
              // onPressed: () {
              //   // Add the suggestion to the gratitude list
              // },
            ))
                .toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPracticeAffirmationsSection(BuildContext context) {
    final affirmationTypes = [
      'Positive',
      'Healing',
      'Powerful',
      'Career',
      'Inspiration',
      'Myself',
      'My Body',
      'Success',
      'Relationships',
      'Motivation'
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Practice ',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              TextSpan(
                text: 'Affirmations',
                style: Theme.of(context)
                    .textTheme
                    .headlineMedium
                    ?.copyWith(color: KColors.kApp4),
              ),
            ],
          ),
        ),
        const SizedBox(height: KSizes.spaceBtwItems),
        Text(
          'Choose an affirmation type to see related statements:',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const SizedBox(height: KSizes.defaultSpace),
        SizedBox(
          height: 300,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            // physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: affirmationTypes.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () => _showAffirmationList(
                    context, affirmationTypes[index]),
                child: Container(
                  decoration: BoxDecoration(
                    color: KColors.kApp4.withOpacity(0.1),
                    border: Border.all(color: KColors.kApp4),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      affirmationTypes[index],
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge
                          ?.copyWith(color: KColors.kApp4),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: KSizes.defaultSpace*5),

      ],
    );
  }

  void _showAffirmationList(BuildContext context, String type) {
    final affirmations = {
      'Positive': [
        'I am confident and capable.',
        'I believe in myself and my abilities.',
        'Every day, I am getting better and better.',
      ],
      'Healing': [
        'I am healthy, healed, and whole.',
        'My body knows how to heal itself.',
        'I am grateful for my health and well-being.',
      ],
      'Powerful': [
        'I am powerful beyond measure.',
        'I have the power to create change.',
        'I am in control of my life and my destiny.',
      ],
      'Career': [
        'I am successful in my career.',
        'I am a valuable asset to my team.',
        'I am open to new opportunities and challenges.',
      ],
      'Inspiration': [
        'I am inspired by the world around me.',
        'I am creative and full of ideas.',
        'I am motivated to achieve my goals.',
      ],
      'Myself': [
        'I love and accept myself unconditionally.',
        'I am worthy of love and respect.',
        'I am enough just as I am.',
      ],
      'My Body': [
        'I am grateful for my body and all it does for me.',
        'I treat my body with love and respect.',
        'I am healthy, strong, and vibrant.',
      ],
      'Success': [
        'I am successful in all that I do.',
        'I attract success and abundance into my life.',
        'I am a magnet for prosperity and good fortune.',
      ],
      'Relationships': [
        'I am surrounded by love and support.',
        'I attract positive and healthy relationships.',
        'I am a good friend and partner.',
      ],
      'Motivation': [
        'I am motivated and driven to achieve my goals.',
        'I am focused and determined to succeed.',
        'I am capable of overcoming any obstacle.',
      ],

    };

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('$type Affirmations'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: affirmations[type]!
                  .map((affirmation) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(affirmation),
              ))
                  .toList(),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
