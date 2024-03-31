import 'package:flutter/cupertino.dart';
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
          onTap: () => back! ? Get.back() : Get.toNamed(KRoutes.getSettingsRoute()),
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
                      KImages.avatarF,
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
                icon: const Icon(CupertinoIcons.bell,size: KSizes.iconXl,),
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
