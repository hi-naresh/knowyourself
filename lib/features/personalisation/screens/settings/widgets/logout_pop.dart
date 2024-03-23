import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../controller/profile_controller.dart';


class LogoutPop extends StatelessWidget {
  const LogoutPop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());
    return Container(
      height: Get.height * 0.4,
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Log Out',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: KSizes.spaceBtwItems),
          Text(
            'Are you sure you want to log out?',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: KSizes.spaceBtwSections),
          ElevatedButton(
            onPressed: () => controller.logoutUser(),
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: KSizes.md,
                ),
              ),
            ),
            child: const Text('Log Out'),
          ),
          const SizedBox(height: KSizes.spaceBtwItems),
          OutlinedButton(
            onPressed: () {
              Get.back();
            },
            style: ButtonStyle(
              padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: KSizes.md,
                ),
              ),
            ),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }
}
