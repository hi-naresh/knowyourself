import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controller/app_controller.dart';
import '../../../controller/profile_setup_controller.dart';

class ProfileAvatarPage extends StatelessWidget {
  final ProfileSetupController? controller;

  const ProfileAvatarPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      children: [
        TextFormField(
          key: const Key('name_field'),
          decoration: const InputDecoration(
            hintText: KTexts.hintText3,
          ),
          onChanged: (value) => controller!.name.value = value,
        ),
        const SizedBox(height: KSizes.defaultSpace * 2),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: KSizes.sm,
              mainAxisSpacing: KSizes.md,
              childAspectRatio: 1, // Add childAspectRatio for square grids
            ),
          itemCount: 12, // Assuming you have 12 avatars
          itemBuilder: (context, index) {
            // Handle the 'no avatar' option
            if (index == 11) {
              return Obx(
                  ()=> GestureDetector(
                  onTap: () => controller!.setAvatar(''),
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: controller!.avatar.value.isEmpty
                        ? KColors.primary // Highlight if selected
                        :KColors.transparent,
                    child: const Icon(
                                  CupertinoIcons.nosign, size: KSizes.iconMd*2,
                                ),
                  ),
                ),
              );
            }

            String avatarPath = 'assets/avatars/avatar${index + 1}.svg';
            return Obx(
              ()=> GestureDetector(
                onTap: () => controller!.setAvatar(avatarPath),
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: controller!.avatar.value == avatarPath
                      ? KColors.primary  // Highlight if selected
                      :KColors.transparent,
                  child: SvgPicture.asset(
                    avatarPath,
                    height: 70,
                  ),
                ),
              ),
            );
          },
        ),
        const SizedBox(height: KSizes.defaultSpace * 2),
        OutlinedButton(onPressed: ()=>AppStateController.instance.logoutUser(),
            child: const Text(KTexts.logoutTitle)),
      ],
    );
  }
}
