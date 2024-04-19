import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/colors.dart';
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
                  controller: controller.emailReset,
                  decoration: const InputDecoration(
                    labelText: KTexts.email,
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                  style: const ButtonStyle().copyWith(
                      minimumSize: MaterialStateProperty.all(
                          const Size(double.infinity, 50)),
                      backgroundColor: MaterialStateProperty.all(KColors.kApp1),
                      foregroundColor: MaterialStateProperty.all(KColors.textWhite)),
                  onPressed: ()=> controller.resetPassword(),
                  child: Text(
                    KTexts.submit,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: KColors.textWhite, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
