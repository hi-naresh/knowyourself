import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/routes.dart';
import 'package:knowyourself/utils/constants/enums.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controller/add_mood_controller.dart';
import '../../../model/activity_model.dart';
import 'helpers/activity_tile.dart';

class ActivitiesToShiftScreen extends StatelessWidget {
  const ActivitiesToShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AddMoodController>();
    return Scaffold(
      appBar: const KAppBar(back: true,),
      body: Padding(
        padding: const EdgeInsets.all( KSizes.defaultSpace),
        child: Column(
          children: [
            Text("Enlighten yourself by",
            style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: KSizes.defaultSpace),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 8,
                children: LifeAspects.values
                    .map((period) => ChoiceChip(
                  backgroundColor: KHelper.isDark()
                      ? kEmptyProgressDark
                      : kEmptyProgress,
                  selectedColor: kApp1,
                  shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(12),
                  disabledColor: kEmptyProgress,
                  label: Text(period.name.capitalizeFirst!),
                  selected: LifeAspects.mental == period,
                  // onSelected: (selected) {
                  //   if (selected) {
                  //     controller.reminderPeriod.value = period;
                  //   }
                  // },
                ))
                    .toList(),
              ),
            ),
            const SizedBox(height: KSizes.defaultSpace),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: KSizes.defaultSpace,
                  mainAxisSpacing: KSizes.defaultSpace,
                ),
                itemCount: controller.activitiesTitle.length,
                itemBuilder: (context, index) {
                  final activity = Activity(title: controller.activitiesTitle[index], duration: "5 mins", imageUrl: "assets/illustrations/health2.svg", color: kApp1);
                  return ActivityTile(
                    activity: activity,
                    onTap: (){},
                  );
                },
              ),
            ),
            TextButton(
                style: const ButtonStyle().copyWith(
                    minimumSize: MaterialStateProperty.all(
                        const Size(double.infinity, 60)),
                    backgroundColor: MaterialStateProperty.all(kApp1),
                    foregroundColor: MaterialStateProperty.all(Colors.white)),
                onPressed: ()=> Get.offAllNamed(KRoutes.getMasterRoute()),
                child: Text(
                  'Go to Dashboard',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                )),
          ],
        ),
      ),
    );
  }
}
