import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';
import '../../../../mySpace/mood/controller/recommend_controller.dart';
import '../../../../mySpace/mood/screens/add_mood/widgets/activities_to_shift.dart';
import '../../../../mySpace/mood/screens/add_mood/widgets/helpers/activity_info_card.dart';
import '../../../../mySpace/mood/screens/add_mood/widgets/helpers/activity_tile.dart';

class RecommendSection extends StatelessWidget {
  const RecommendSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ActivityController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(KTexts.recommend, style: Theme.of(context).textTheme.headlineSmall),
              GestureDetector(
                onTap: ()=> Get.to(()=>const ActivitiesToShiftScreen()),
                child: Text(
                  "${KTexts.view} ${KTexts.all}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: KSizes.defaultSpace),
        SizedBox(
          height: 130,
          child: ListView.separated(
            clipBehavior: Clip.none,
            scrollDirection: Axis.horizontal,
            // gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //   crossAxisCount: 1,
            //   crossAxisSpacing: KSizes.defaultSpace,
            //   mainAxisSpacing: KSizes.defaultSpace,
            //
            // ),
            separatorBuilder: (context, index) => const SizedBox(width: KSizes.defaultSpace),

            itemCount: controller.activities.length,
            itemBuilder: (context, index) {
              return ActivityTile(
                activity: controller.activities[index],
                onTap: ()=> Get.to(()=>ActivityInfoCard(activityModel: controller.activities[index])),
              );
            },
          ),
        ),
      ]
    );
  }
}
