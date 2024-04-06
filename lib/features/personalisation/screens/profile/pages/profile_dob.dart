import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import '../../../controller/profile_setup_controller.dart';

class ProfileDobPage extends StatelessWidget {
  final ProfileSetupController controller;

  const ProfileDobPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      children: [
        InkWell(
            onTap: () => controller.pickDate(context),
            child: InputDecorator(
              decoration: const InputDecoration(
                labelText: "Date of Birth",
                border: OutlineInputBorder(),
              ),
              child: Obx(() => Text(controller.dob.value != null
                  ? KHelper.getFormattedDateString(controller.dob.value!)
                  : 'Select date')),
            )
        ),
        const SizedBox(height: KSizes.defaultSpace),
        Text(
            "What is your gender?",
            style: Theme.of(context).textTheme.titleMedium
        ),
        const SizedBox(height: KSizes.spaceBtwItems),
        Obx(
    ()=> ToggleButtons(
            selectedColor: KColors.white,
            fillColor: kApp1,
            borderRadius: BorderRadius.circular(KSizes.borderRadiusLgx),
            verticalDirection: VerticalDirection.down,
            isSelected: controller.genderSelections,
            onPressed: (int index) {
              controller.genderSelections[index] = !controller.genderSelections[index];
            },
            children: const [
              Text('Male'),
              Text('Female'),
              Text('Other'),
            ].map((e) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
              child: e,
            )).toList(),
          ),
        ),
      ],
    );
  }
}
