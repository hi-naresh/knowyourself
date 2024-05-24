import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/pagebar.dart';
import 'package:knowyourself/features/personalisation/screens/profile/pages/profile_avatar.dart';
import 'package:knowyourself/features/personalisation/screens/profile/pages/profile_dob.dart';
import 'package:knowyourself/features/personalisation/screens/profile/pages/profile_member_type.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/text_strings.dart';
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

    return Obx(
        ()=> Scaffold(
        appBar: KPageBar(
            title: '${KTexts.profile} ${KTexts.setup}',
            showBackButton: controller.pageIndex.value > 0,
            // action: controller.pageIndex.value == 0 ? FilledButton(
            //   child: Text('Logout', style: Theme.of(context).textTheme.labelSmall?.copyWith(
            //     color: KColors.white,
            //   ),),
            //   onPressed: ()=>AppStateController.instance.logoutUser()
            // ) : null,
            onTap: controller.goToPreviousPage),
        body: PopScope(child: pages[controller.pageIndex.value]),
        bottomNavigationBar: BottomAppBar(
            elevation: 0,
            color: KColors.transparent,
            child: controller.pageIndex.value == 2
                ? ElevatedButton(
              onPressed: controller.finishOnboarding,
              child: const Text( KTexts.finish),
            )
                : ElevatedButton(
              onPressed: controller.goToNextPage,
              child: const Text(KTexts.next),
            )),
      ),
    );
  }
}
