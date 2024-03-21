import 'package:flutter/material.dart';
import 'package:knowyourself/features/insights/controller/dashboard_controller.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';
import '../../../../../common/widgets/custom_container.dart';
import 'package:get/get.dart';

import '../../../../mySpace/mood/screens/add_mood/add_mood_screen.dart';
import '../../../../personalisation/controller/user_controller.dart';
class MoodSection extends StatelessWidget {
  const MoodSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DashboardController());
    final userController = Get.put(UserController());
    return CustomContainer(
      width: double.infinity,
      color: kApp1Light,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //consumer to provide the user's name
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: controller.greeting(),
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextSpan(
                  text: "${userController.user.value.fullName!}!",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextSpan(
                  text: "\n${KTexts.feel}",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ],
            ),
            ),


          const SizedBox(height: KSizes.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(13),
                  color: const Color(0x4DF5F5F5),
                ),
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "Express Your Mood & Reflect:\nLog emotions and thoughts.",
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.left,
                ),
              ),
              const Spacer(),
              Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xff393939), // Change the color as needed
                  ),
                  child: IconButton(
                    onPressed: () {
                      //navigate
                      Get.to( () => const AddMoodScreen());
                    },
                    icon: const Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
