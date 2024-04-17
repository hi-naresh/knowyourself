import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../../../utils/constants/text_strings.dart';
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
                labelText: KTexts.birthDate,
                border: OutlineInputBorder(),
              ),
              child: Obx(() => Text(controller.dob.value != null
                  ? KHelper.getFormattedDateString(controller.dob.value!)
                  : KTexts.selectDate)),
            )),
        const SizedBox(height: KSizes.defaultSpace),
        Text( KTexts.gender,
            style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: KSizes.spaceBtwItems),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Wrap(
            spacing: 10,
            direction: Axis.horizontal,
            children: Gender.values.map((gender) {
              return Obx(
                    () => ChoiceChip(
                  backgroundColor: KHelper.isDark()
                      ? kEmptyProgressDark
                      : kEmptyProgress,
                  selectedColor: kApp1,
                  label: Text(
                      gender.toString().split('.').last.capitalize!),
                  selected: controller.selectedGender.value == gender,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: kApp1,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.all(10),
                  disabledColor: kEmptyProgress,
                  onSelected: (_)=> controller.selectedGender.value = gender,
                  // onSelected: (_) => controller.changeAspect(gender),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
