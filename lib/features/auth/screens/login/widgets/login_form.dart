import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../routes.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../../../utils/validators/validation.dart';
import '../../../controller/login/login_controller.dart';

class PLoginForm extends StatelessWidget {
  const PLoginForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return Form(
      key: controller.loginFormKey,
      child: Column(
        children: [
          TextFormField(
            controller: controller.email,
            validator: (value) =>
                KValidator.validateEmpty(value, controller.email.text),
            decoration: const InputDecoration(
              labelText: KTexts.username,
              hintText: KTexts.usernameHint,
            ),
          ),
          const SizedBox(height: KSizes.spaceBtwInputFields),
          Obx(
            () => TextFormField(
              controller: controller.password,
              validator: (value) =>
                  KValidator.validateEmpty(value, controller.password.text),
              obscureText: controller.hidePassword.value,
              decoration: InputDecoration(
                  labelText: KTexts.password,
                  hintText: KTexts.passwordHint,
                  suffixIcon: IconButton(
                      onPressed: () => controller.hidePassword.value =
                          !controller.hidePassword.value,
                      icon: const Icon(Icons.remove_red_eye_outlined))),
            ),
          ),
          const SizedBox(height: KSizes.spaceBtwInputFields),
          //remember me and forgot password
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Obx(
                    () => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: (value) => controller.rememberMe.value =
                            !controller.rememberMe.value),
                  ),
                  const Text(KTexts.rememberMe),
                ],
              ),
              TextButton(
                onPressed: () {
                  Get.toNamed(KRoutes.getPasswordResetRoute());
                },
                child: const Text(KTexts.forgetPassword),
              ),
            ],
          ),
          const SizedBox(height: KSizes.spaceBtwInputFields),
          //signIn and create account button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.emailLogin(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(KSizes.md),
              ),
              child: const Text(KTexts.signIn),
            ),
          ),
          const SizedBox(height: KSizes.defaultSpace),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () {
                Get.toNamed(KRoutes.getSignupRoute());
              },
              child: const Text(KTexts.createAccount),
            ),
          ),
        ],
      ),
    );
  }
}
