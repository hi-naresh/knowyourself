import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';
import '../../../features/personalisation/controller/profile_setup_controller.dart';
import '/utils/device/device_utility.dart';
import '../../../utils/constants/sizes.dart';
import '../../../routes.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar(
      {super.key, this.back = false, this.title, this.showNotification = true});

  final bool? back;
  final String? title;
  final bool? showNotification;

  @override
  Widget build(BuildContext context) {
    final profileController = ProfileSetupController.instance;
    return AppBar(
      title: Text(title ?? ''),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: KSizes.defaultSpace),
        child: GestureDetector(
          onTap: () =>
              back! ? Get.back() : Get.toNamed(KRoutes.getSettingsRoute()),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: back!
                ? const Icon(
                    CupertinoIcons.clear_thick,
                    size: KSizes.iconSm,
                    color: KColors.white,
                  )
                : CircleAvatar(
                    backgroundColor: KColors.primary,
                    child: SvgPicture.asset(
                      profileController.userProfile.value.avatarPath ??
                          KImages.defaultAvatar,
                      height: KSizes.iconXxl,
                      fit: BoxFit.cover,
                    ),
                  ),
          ),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: KSizes.spaceBtwItems),
          child: Row(
            children: [
              showNotification!
                  ? IconButton(
                      onPressed: () {
                        Get.toNamed(KRoutes.getNotificationsRoute());
                      },
                      icon: const Icon(
                        CupertinoIcons.bell,
                        size: KSizes.iconXl,
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(KDeviceUtils.getAppBarHeight());
}

class KAppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  const KAppBarCustom({
    super.key,
    this.back = false,
    this.title,
    this.showNotification = true,
    this.extraActions, // New optional parameter for extra actions
  });

  final bool? back;
  final String? title;
  final bool? showNotification;
  final List<Widget>? extraActions; // New optional parameter for extra actions

  @override
  Widget build(BuildContext context) {
    final profileController = ProfileSetupController.instance;

    return AppBar(
      title: Text(title ?? ''),
      centerTitle: true,
      leading: Padding(
        padding: const EdgeInsets.only(left: KSizes.defaultSpace),
        child: GestureDetector(
          onTap: back! ? () => Get.toNamed(KRoutes.getMasterRoute()) : ()=> Get.toNamed(KRoutes.getSettingsRoute()),
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: back!
                ? const Icon(
                    CupertinoIcons.clear_thick,
                    size: KSizes.iconSm,
                    color: KColors.white,
                  )
                : CircleAvatar(
                    backgroundColor: KColors.primary,
                    child: profileController.userProfile.value.avatarPath == ""
                        ? const Icon(
                            CupertinoIcons.person,
                            size: KSizes.iconXl,
                            color: KColors.textPrimary,
                          )
                        : SvgPicture.asset(
                            profileController.userProfile.value.avatarPath!,
                            height: KSizes.iconXxl,
                            fit: BoxFit.contain,
                          )
                    // child: SvgPicture.asset(
                    //   profileController.userProfile.value.avatarPath ?? KImages.defaultAvatar,
                    //   height: KSizes.iconXxl,
                    //   fit: BoxFit.cover,
                    // ),
                    ),
          ),
        ),
      ),
      actions: [
        if (showNotification!)
          IconButton(
            onPressed: () {
              Get.toNamed(KRoutes.getNotificationsRoute());
            },
            icon: const Icon(CupertinoIcons.bell, size: KSizes.iconXl),
          ),
        if (extraActions != null) ...extraActions!,
        // Adding extra actions if provided
        const SizedBox(width: KSizes.spaceBtwItems),
        // Space at the end
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(KDeviceUtils.getAppBarHeight());
}
