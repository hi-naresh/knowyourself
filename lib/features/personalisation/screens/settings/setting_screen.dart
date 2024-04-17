import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/personalisation/controller/app_controller.dart';
import '../../../../data/helper_service/local_auth/local_bio_auth.dart';
import '../../../../routes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controller/profile_setup_controller.dart';
import '/features/personalisation/screens/settings/widgets/logout_pop.dart';
import '/features/personalisation/screens/settings/widgets/settings_tile.dart';
import '/utils/constants/sizes.dart';
import '/utils/helpers/helper_functions.dart';

import '../../../../common/widgets/appbar/appbar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final appController = AppStateController.instance;
    final bioController = LocalBioAuth.instance;
    final profileController = ProfileSetupController.instance;
    return Scaffold(
      appBar: const KAppBar(
        back: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KSizes.md, vertical: 0),
        child: ListView(
          children: [
            Column(
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
                        profileController.userProfile.value.avatarPath ?? KImages.defaultAvatar,
                        height: KSizes.iconXxl*2,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Obx(
                        ()=> Text(
                      profileController.userProfile.value.name ?? "No user",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  subtitle: Obx(()=> Text(profileController.userProfile.value.occupation?? "Setup your profile.")),
                  trailing: IconButton(
                    icon: const Icon(CupertinoIcons.paperplane),
                    onPressed: () {
                      // Navigate to the profile edit screen
                      Get.toNamed(KRoutes.getProfileEditRoute());
                    },
                  ),
                ),
                const SizedBox(height: KSizes.spaceBtwSections),
                // ElevatedButton(onPressed: ()=>Get.to(()=>const ProfileSetupScreen()),
                //     child: Text("Test")),
                // ElevatedButton(onPressed: ()=> appController.getData(), child: Text("Test2")),
                SettingTile(
                  title: KTexts.darkModeTitle,
                  subtitle: KTexts.darkModeSubtitle,
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
                    title: KTexts.bioMetricLoginTitle,
                    subtitle: KTexts.bioMetricLoginSubtitle,
                    trailing: Obx(
                          ()=> CupertinoSwitch(
                        value: bioController.isAuthEnabled.value,
                        onChanged: (value) async {
                          if(value){
                            await bioController.toggleBioAuth(value);
                            KHelper.showSnackBar("Biometric Enabled now","All your personal spaces will be locked.");
                          }else{
                            final isAuth = await bioController.authenticateWithBiometrics();
                            if(isAuth){
                              await bioController.toggleBioAuth(value);
                              KHelper.showSnackBar("Biometric Disabled now","All your personal spaces are unlocked.");
                            }else{
                              KHelper.showSnackBar("Authentication Failed","Biometric Authentication could not be disabled");
                            }
                          }
                        },
                        activeColor: Theme.of(context).primaryColor,
                      ),
                    ),
                    icon: CupertinoIcons.eye_slash),
                SettingTile(
                  title: KTexts.notificationsTitle,
                  subtitle: KTexts.notificationsSubtitle,
                  trailing: CupertinoSwitch(
                    value: true,
                    onChanged: (value) {},
                    activeColor: Theme.of(context).primaryColor,
                  ),
                  icon: CupertinoIcons.bell,
                ),


                SettingTile(
                    title: KTexts.mySpaceTitle,
                    subtitle: KTexts.mySpaceSubtitle,
                    onTap: ()=> Get.toNamed(KRoutes.getSettingSpaceRoute()),
                    trailing: const Icon(CupertinoIcons.forward),
                    icon: CupertinoIcons.sparkles),

                const SettingTile(
                    title: KTexts.feedbackTitle,
                    subtitle: KTexts.feedbackSubtitle,
                    trailing: Icon(CupertinoIcons.forward),
                    icon: CupertinoIcons.conversation_bubble),
                SettingTile(
                    title: KTexts.aboutTitle,
                    onTap: ()=> Get.toNamed(KRoutes.getAboutRoute()),
                    subtitle: KTexts.aboutSubtitle,
                    trailing: const Icon(CupertinoIcons.forward),
                    icon: CupertinoIcons.layers_alt),
                SettingTile(
                    onTap: () {
                      KHelper.showBottomSheet(const LogoutPop());
                    },
                    title: KTexts.logoutTitle,
                    subtitle: KTexts.logoutSubtitle,
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
                  KTexts.madeForSAILC,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
