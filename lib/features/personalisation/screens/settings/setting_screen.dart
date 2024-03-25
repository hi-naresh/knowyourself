import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/personalisation/controller/app_controller.dart';
import '../../../../routes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '/features/personalisation/screens/settings/widgets/logout_pop.dart';
import '/features/personalisation/screens/settings/widgets/settings_tile.dart';
import '/utils/constants/sizes.dart';
import '/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../../controller/user_controller.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    final appController = AppStateController.instance;
    return Scaffold(
      appBar: const KAppBar(
        back: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KSizes.md, vertical: 0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //profile card
              const SizedBox(height: KSizes.defaultSpace),
              ListTile(
                leading:Container(
                clipBehavior: Clip.hardEdge,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  shape: BoxShape.circle,
                ),
                child: CircleAvatar(
                  radius: KSizes.iconMd,
                  backgroundColor: KColors.primary,
                  child: SvgPicture.asset(
                    KImages.avatarF,
                    height: KSizes.iconLg*1.6,
                  ),
                ),
              ),
                title: Obx(
                  ()=> Text(
                    controller.user.value.fullName ?? "No user",
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
                subtitle: Obx(()=> Text(controller.user.value.username ?? "No email")),
                trailing: IconButton(
                  icon: const Icon(CupertinoIcons.paperplane),
                  onPressed: () {
                    // Navigate to the profile edit screen
                    Get.toNamed(KRoutes.getProfileEditRoute());
                  },
                ),
              ),

              const SizedBox(height: KSizes.spaceBtwSections),

              // ReminderNotificationWidget(),
              SettingTile(
                title: "Dark Mode",
                subtitle: "Switch to dark mode",
                trailing:Obx(() => CupertinoSwitch(
                  value: appController.isDarkMode.value,
                  onChanged: (value) {
                    appController.toggleTheme();
                  },
                  activeColor: Theme.of(context).primaryColor,
                ),
                ) ,
                icon: CupertinoIcons.moon_circle,
              ),

            SettingTile(
                  title: "Bio-metric Login",
                  subtitle: "Login with your face/fingerprint",
                  trailing: CupertinoSwitch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  icon: CupertinoIcons.eye_slash),
              SettingTile(
                title: "Notifications",
                subtitle: "In order to remind your tasks.",
                trailing: CupertinoSwitch(
                  value: true,
                  onChanged: (value) {},
                  activeColor: Theme.of(context).primaryColor,
                ),
                icon: CupertinoIcons.bell,
              ),
              const SettingTile(
                  title: "About",
                  subtitle: "Know more about KYB",
                  trailing: Icon(CupertinoIcons.forward),
                  icon: CupertinoIcons.layers_alt),
              const SettingTile(
                  title: "Help",
                  subtitle: "Get help from KYB",
                  trailing: Icon(CupertinoIcons.forward),
                  icon: CupertinoIcons.conversation_bubble),
              SettingTile(
                  onTap: () {
                    KHelper.showBottomSheet(const LogoutPop());
                  },
                  title: "Logout",
                  subtitle: "Logout from KYB",
                  trailing: const Icon(CupertinoIcons.forward),
                  icon: CupertinoIcons.square_arrow_left),
              const SizedBox(height: KSizes.spaceBtwSections),
              Image.asset(
                KImages.sailcLogo,
                height: 40,
              ),
              const SizedBox(
                height: KSizes.md,
              ),
              Text(
                "Made for SAILC",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
      ),
    );
  }

}
