import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/pagebar.dart';
import 'package:knowyourself/features/personalisation/controller/profile_setup_controller.dart';
import 'package:knowyourself/features/personalisation/screens/profile/profile_edit_fields.dart';
import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/helpers/helper_functions.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KPageBar(
        title: '${KTexts.edit} ${KTexts.profile} ',
        onTap: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Obx(
            ()=> Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                if (ProfileSetupController.instance.userProfile.value.avatarPath != null)
                Row(
                  mainAxisSize: MainAxisSize.max,
                      children: [
                        SvgPicture.asset(ProfileSetupController.instance.userProfile.value.avatarPath!.toString(),
                          height: 140,
                          fit: BoxFit.cover,),
                        const SizedBox(width: KSizes.defaultSpace),
                        // Text(ProfileSetupController.instance.userProfile.value.name ?? 'No user',
                        //   style: Theme.of(context).textTheme.headlineSmall,
                        // ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: ProfileSetupController.instance.userProfile.value.name ?? KTexts.noUser,
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),
                              TextSpan(
                                text: '\n ${KTexts.rewardPoints} : ${ProfileSetupController.instance.userProfile.value.rewardPoints}\n\n',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),

                      ],
                    ),
                const SizedBox(height: KSizes.defaultSpace),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Text(KTexts.personalInfo, style: Theme.of(context).textTheme.headlineSmall),
                ),
                const SizedBox(height: KSizes.sm),
                ListTile(
                  title: const Text(KTexts.occupationLabelText),
                  trailing: Text(ProfileSetupController.instance.userProfile.value.occupation ?? KTexts.noUser,
                  style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                ListTile(
                  title: const Text(KTexts.gender),
                  trailing: Text(
                      style: Theme.of(context).textTheme.bodyMedium,
                      ProfileSetupController.instance.userProfile.value.gender ?? KTexts.noUser),
                ),
                ListTile(
                  title: const Text(KTexts.birthDate),
                  trailing: Text(
                      style: Theme.of(context).textTheme.bodyMedium,
                      KHelper.getFormattedDateString(ProfileSetupController.instance.userProfile.value.dob!)),
                ),
                ListTile(
                  title: const Text(KTexts.userTypeText),
                  trailing: Text(
                      style: Theme.of(context).textTheme.bodyMedium,
                      ProfileSetupController.instance.userProfile.value.userType?.split('.').last ?? KTexts.noUser),
                ),
                ListTile(
                  title: const Text(KTexts.institutionLabelText),
                  trailing: Text(
                      style: Theme.of(context).textTheme.bodyMedium,
                      ProfileSetupController.instance.userProfile.value.institution ?? KTexts.noUser),
                ),
                const SizedBox(height: KSizes.defaultSpace,),
                ElevatedButton(
                    onPressed: ()=> Get.to(()=>const EditPersonalInfo()),
                    child: const Text(KTexts.editInfo))

              ],
            ),
          ),
        ),
      )
    );
  }
}
