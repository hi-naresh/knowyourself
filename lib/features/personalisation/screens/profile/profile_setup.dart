import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/pagebar.dart';
import 'package:knowyourself/features/personalisation/screens/profile/pages/profile_avatar.dart';
import 'package:knowyourself/features/personalisation/screens/profile/pages/profile_dob.dart';
import 'package:knowyourself/features/personalisation/screens/profile/pages/profile_member_type.dart';

import '../../controller/profile_setup_controller.dart';

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileSetupController());

    List<Widget> pages = [
      ProfileAvatarPage(controller: controller),
      ProfileDobPage(controller: controller),
      ProfileMemberPage(controller: controller),
    ];

    return Scaffold(
      appBar: KPageBar(title: 'Profile Setup', onTap: controller.goToPreviousPage),
      body: Obx(() => Center(child: pages[controller.pageIndex.value])),
      bottomNavigationBar: Obx(
          ()=> BottomAppBar(
          elevation: 0,
          color: Colors.transparent,
          child: controller.pageIndex.value == 2? ElevatedButton(
            onPressed: controller.finishOnboarding,
            child: const Text('Finish'),
          ) : ElevatedButton(
            onPressed: controller.goToNextPage,
            child: const Text('Next'),
          )
        ),
      ),
    );
  }
}
