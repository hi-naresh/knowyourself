import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/sizes.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../controller/pass_reset/pass_reset_controller.dart';

class PasswordResetScreen extends StatelessWidget {
  const PasswordResetScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PasswordResetController());
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                KTexts.forgetPasswordTitle,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
              ),
              const SizedBox(height: KSizes.spaceBtwItems),
              const Text(KTexts.forgetPasswordSubTitle),
              const SizedBox(height: KSizes.spaceBtwItems),
              Form(
                key: controller.passwordResetFormKey,
                child: TextFormField(
                  controller: controller.email,
                  decoration: const InputDecoration(
                    labelText: KTexts.email,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => controller.resetPassword(),
                child: const Text(KTexts.submit),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
