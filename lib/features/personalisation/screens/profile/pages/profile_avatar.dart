import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../controller/profile_setup_controller.dart';

class ProfileAvatarPage extends StatelessWidget {
  final ProfileSetupController controller;

  const ProfileAvatarPage({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      children: [
        TextFormField(
          key: const Key('name_field'),
          decoration: const InputDecoration(
            hintText: 'What should we call you?',
          ),
          onChanged: (value) => controller.name.value = value,
        ),
        const SizedBox(height: KSizes.defaultSpace * 2),
        GridView.builder(
          shrinkWrap: true, // Add shrinkWrap to true inside ListView
          physics: const NeverScrollableScrollPhysics(), // Add this line to ensure scroll physics works correctly
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            crossAxisSpacing: KSizes.sm,
            mainAxisSpacing: KSizes.md,
            childAspectRatio: 1, // Add childAspectRatio for square grids
          ),
          itemCount: 12, // Update this count to the number of avatars
          itemBuilder: (context, index) {
            if (index ==11){
              return GestureDetector(
                // onTap: () => controller.setAvatarIndex(index), // Implement the setAvatarIndex method
                child:  const CircleAvatar(
                  maxRadius: 30,
                  backgroundColor: Colors.transparent,
                  child: Icon(
                    CupertinoIcons.nosign, size: KSizes.iconMd*2,
                    color: kApp1,
                  ),
                ),
              );
            }
            return GestureDetector(
              onTap: () =>controller.setAvatar('assets/avatars/avatar$index.svg') ,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  'assets/avatars/avatar${index + 1}.svg', // Indexing starts at 1 for asset files
                  height: 70,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
