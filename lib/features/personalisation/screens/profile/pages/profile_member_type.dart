import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../../utils/constants/enums.dart';
import '../../../controller/profile_setup_controller.dart';

class ProfileMemberPage extends StatelessWidget {
  final ProfileSetupController controller;

  const ProfileMemberPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      children: [
        TextFormField(
          key: const Key('occupation_field'),
          decoration: const InputDecoration(
            labelText: 'Occupation',
            hintText: 'Enter your occupation',
          ),
          onChanged: (value) => controller.occupation.value = value,
        ),
        const SizedBox(height: KSizes.defaultSpace),
        TextFormField(
          key: const Key('institution_field'),
          decoration: const InputDecoration(
            labelText: 'Institution/School/College',
            hintText: 'Enter your institution',
          ),
          onChanged: (value) => controller.institution.value = value,
        ),
        const SizedBox(height: KSizes.defaultSpace),
        Text(
          'Please choose one that best describes your Affiliation?',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        Obx(
          () => DropdownButton<UserType>(
            value: controller.userType.value,
            isExpanded: true,
            hint: const Text('Select User Type'),
            borderRadius: BorderRadius.circular(KSizes.borderRadiusLg),
            onChanged: (UserType? value) {
              controller.userType.value = value!;
            },
            padding: const EdgeInsets.all(KSizes.sm),
            underline: const SizedBox(),
            items: UserType.values
                .map<DropdownMenuItem<UserType>>((UserType value) {
              return DropdownMenuItem<UserType>(
                value: value,
                child: Text(value.toString().split('.').last.splitMapJoin(
                      RegExp(r"(?=[A-Z])"),
                      onMatch: (m) => ' ',
                      onNonMatch: (m) => m,
                    ).capitalizeFirst!,
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
