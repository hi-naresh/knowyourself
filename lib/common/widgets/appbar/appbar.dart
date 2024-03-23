import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';
import '/utils/device/device_utility.dart';
import '../../../utils/constants/sizes.dart';
import '../../../routes.dart';

class KAppBar extends StatelessWidget implements PreferredSizeWidget {
  const KAppBar({super.key, this.back = false});
  final bool? back;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // title: Text(KTexts.appName),
      // centerTitle: true,
      // flexibleSpace: const CustomHeader( title: KTexts.appName,),
      leading: Padding(
        padding: const EdgeInsets.only(left: KSizes.defaultSpace),
        child: GestureDetector(
          onTap: () {
            if (back == true) {
              Get.back();
            } else {
              Get.toNamed(KRoutes.getSettingsRoute());
            }
          },
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: back!
                ? const Icon(
                    Icons.close_rounded,
                    size: KSizes.iconMd,
                    color: KColors.white,
                  )
                : CircleAvatar(
                    backgroundColor: KColors.primary,
                    child: SvgPicture.asset(
                      KImages.avatarM,
                      height: KSizes.iconLg,
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
              IconButton(
                onPressed: () {
                  Get.toNamed(KRoutes.getNotificationsRoute());
                },
                icon: SvgPicture.asset(
                  "assets/icons/bell.svg",
                  height: KSizes.iconXl,
                  color: Theme.of(context).textTheme.labelLarge?.color,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(KDeviceUtils.getAppBarHeight());
}
