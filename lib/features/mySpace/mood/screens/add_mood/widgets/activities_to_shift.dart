import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/mood/controller/recommend_controller.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/helpers/activity_info_card.dart';
import 'package:knowyourself/routes.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../../../common/widgets/appbar/appbar.dart';
import 'helpers/activity_tile.dart';

class ActivitiesToShiftScreen extends StatelessWidget {
  const ActivitiesToShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ActivityController());
    return Scaffold(
      appBar: const KAppBar(back: true,),
      body: Padding(
        padding: const EdgeInsets.all( KSizes.defaultSpace),
        child: Column(
          children: [
            Text("Enlighten yourself By",
            style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: KSizes.defaultSpace),
            // SingleChildScrollView(
            //   scrollDirection: Axis.horizontal,
            //   child: Wrap(
            //     spacing: 8,
            //     children: LifeAspects.values
            //         .map((period) => ChoiceChip(
            //       backgroundColor: KHelper.isDark()
            //           ? kEmptyProgressDark
            //           : kEmptyProgress,
            //       selectedColor: kApp1,
            //       shape: RoundedRectangleBorder(
            //         side: BorderSide.none,
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       padding: const EdgeInsets.all(12),
            //       disabledColor: kEmptyProgress,
            //       label: Text(period.name.capitalizeFirst!),
            //       selected: LifeAspects.mental == period,
            //       // onSelected: (selected) {
            //       //   if (selected) {
            //       //     controller.reminderPeriod.value = period;
            //       //   }
            //       // },
            //     ))
            //         .toList(),
            //   ),
            // ),
            const SizedBox(height: KSizes.defaultSpace),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: KSizes.defaultSpace,
                  mainAxisSpacing: KSizes.defaultSpace,
                ),
                itemCount: controller.activities.length,
                itemBuilder: (context, index) {
                  return ActivityTile(
                    activity: controller.activities[index],
                    onTap: ()=> Get.to(()=>ActivityInfoCard(activityModel: controller.activities[index])),
                  );
                },
              ),
            ),

            ElevatedButton(
                onPressed: ()=> Get.offAllNamed(KRoutes.getMasterRoute()),
                child: const Text('Go to Dashboard')),
          ],
        ),
      ),
    );
  }
}
