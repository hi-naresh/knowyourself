import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/pagebar.dart';
import 'package:knowyourself/features/personalisation/controller/profile_setup_controller.dart';
import 'package:knowyourself/features/personalisation/screens/profile/pages/profile_avatar.dart';

import '../../../../utils/constants/sizes.dart';

class ProfileEditScreen extends StatelessWidget {
  const ProfileEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: KPageBar(
        title: 'Edit Profile',
        onTap: () {
          Get.back();
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
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
                              text: ProfileSetupController.instance.userProfile.value.name ?? 'No user',
                              style: Theme.of(context).textTheme.headlineSmall,
                            ),
                            TextSpan(
                              text: '\nReward points : ${ProfileSetupController.instance.userProfile.value.rewardPoints}\n\n',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            WidgetSpan(
                                child: FilledButton(
                                  onPressed: ()=> Get.to(()=> Scaffold(body: ProfileAvatarPage(controller: ProfileSetupController.instance,))),
                                  child: const Text('Change Avatar'),
                                )
                            )
                          ],
                        ),
                      ),

                    ],
                  ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {},
                child: const Text('Change Profile Picture'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      )
    );
  }
}
