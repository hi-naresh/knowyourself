import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/pagebar.dart';
import 'package:knowyourself/features/master.dart';
import 'package:knowyourself/features/mySpace/digdeeper/screens/digdeeper_screen.dart';
import 'package:knowyourself/features/mySpace/digdeeper/screens/soul_forces_widget.dart';
import 'package:knowyourself/features/mySpace/mood/controller/recommend_controller.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/helpers/activity_info_card.dart';
import 'package:knowyourself/routes.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../../../common/widgets/k_floating_action.dart';
import '../../../../../../utils/constants/text_strings.dart';
import '../../../controller/add_mood_controller.dart';
import '../../../model/activity_info_model.dart';
import 'helpers/activity_tile.dart';

class ActivitiesToShiftScreen extends StatelessWidget {
  const ActivitiesToShiftScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: KPageBar(
        title: '',
        onTap: ()=> Get.offAllNamed(KRoutes.getMasterRoute()),
      ),
      floatingActionButton: const KFloatingAction(
        buttonColor: KColors.kApp3,
        icon: CupertinoIcons.clear,
        screenWidget:MasterScreen(),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all( KSizes.defaultSpace),
        child: Column(
          children: [
            // DigDeeperScreen(),
            SoulForcesWidget(),
            const SizedBox(height: KSizes.defaultSpace),
            const SuggestedActivityWidget(),
            const SizedBox(height: KSizes.defaultSpace*5),
          ],
        ),
      ),
    );
  }
}

class SuggestedActivityWidget extends StatelessWidget {
  const SuggestedActivityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ActivityController());
    final addController = AddMoodController.instance;
    return Padding(
      padding: const EdgeInsets.all( KSizes.defaultSpace),
      child: Column(
        children: [
          Text(
            KTexts.moodLighten,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          // const SizedBox(height: KSizes.defaultSpace),
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
          // Expanded(
          //   child: GridView.builder(
          //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          //       crossAxisCount: 2,
          //       crossAxisSpacing: KSizes.defaultSpace,
          //       mainAxisSpacing: KSizes.defaultSpace,
          //     ),
          //     itemCount: controller.activities.length,
          //     itemBuilder: (context, index) {
          //       return ActivityTile(
          //         activity: controller.activities[index],
          //         onTap: ()=> Get.to(()=>ActivityInfoCard(activityModel: controller.activities[index])),
          //       );
          //     },
          //   ),
          // ),
          SizedBox(
            height: 150,
            child: ListView.separated(
              clipBehavior: Clip.none,
              scrollDirection: Axis.horizontal,
              itemCount: addController.activitiesTitle.length,
              separatorBuilder: (context, index) => const SizedBox(width: KSizes.defaultSpace),
              itemBuilder: (context, index) {
                final activity = ActivityModel(
                  id: index.toString(),
                  userId: "1",
                  title: addController.activities.elementAt(index).title,
                  duration: "5 mins",
                  imageUrl: "assets/illustrations/health2.svg",
                  color: addController.activities.elementAt(index).color,
                );
                return ActivityTile(
                  activity: activity,
                  onTap: ()=> Get.to(()=>ActivityInfoCard(activityModel: addController.activities[index])),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
