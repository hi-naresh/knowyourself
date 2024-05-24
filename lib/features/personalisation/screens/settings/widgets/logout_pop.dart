import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/personalisation/controller/app_controller.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';


class LogoutPop extends StatelessWidget {
  const LogoutPop({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = AppStateController.instance;
    return Container(
      height: Get.height * 0.4,
      padding: const EdgeInsets.all(KSizes.defaultSpace),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            KTexts.logOut,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: KSizes.spaceBtwItems),
          Text(
            KTexts.logOutMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const SizedBox(height: KSizes.spaceBtwSections),
          ElevatedButton(
            onPressed: () => controller.logoutUser(),
            style: ButtonStyle(
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: KSizes.md,
                ),
              ),
            ),
            child: const Text(KTexts.logOut),
          ),
          const SizedBox(height: KSizes.spaceBtwItems),
          OutlinedButton(
            onPressed: () {
              Get.back();
            },
            style: ButtonStyle(
              padding: WidgetStateProperty.all(
                const EdgeInsets.symmetric(
                  vertical: KSizes.md,
                ),
              ),
            ),
            child: const Text(KTexts.cancel),
          ),
        ],
      ),
    );
  }
}
