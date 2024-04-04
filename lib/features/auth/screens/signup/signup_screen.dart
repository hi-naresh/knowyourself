import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/app_links.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import '../../../../utils/validators/validation.dart';
import '../../controller/signup/signup_controller.dart';
import '/features/auth/screens/login/widgets/social_button.dart';
import '/utils/constants/sizes.dart';
import '/utils/constants/text_strings.dart';

import '../login/widgets/pdividier.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignUpController());
    return Scaffold(
      appBar: AppBar(title: const Text(KTexts.signupTitle),),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //form
              Form(
                key : controller.signupFormKey,
                child: Column(
                  children: [
                    //name
                    TextFormField(
                      controller: controller.fullName,
                      validator: (value)=> KValidator.validateEmpty("FullName", value),
                      decoration: const InputDecoration(
                        labelText: KTexts.fullname,
                      ),
                    ),
                    const SizedBox(height: KSizes.spaceBtwItems),
                    //email
                    TextFormField(
                      controller: controller.email,
                      validator: (value)=> KValidator.validateEmail(value),
                      decoration: const InputDecoration(
                        labelText: KTexts.email,
                      ),
                    ),
                    const SizedBox(height: KSizes.spaceBtwItems),
                    //password
                    Obx(
                      ()=> TextFormField(
                        controller: controller.password,
                        obscureText: controller.hidePassword.value,
                        validator: (value)=> KValidator.validatePassword( value),
                        decoration: InputDecoration(
                          labelText: KTexts.password,
                          suffixIcon: IconButton(
                            onPressed: () => controller.hidePassword.value = !controller.hidePassword.value,
                            icon: const Icon(Icons.remove_red_eye_outlined),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: KSizes.spaceBtwItems),
                    //confirm password
                    TextFormField(
                      controller: controller.confirmPassword,
                      obscureText: true,
                      validator: (value) => KValidator.validateConfirmPass(value, controller.password.text),
                      decoration: const InputDecoration(
                        labelText: KTexts.confirmPassword,
                      ),
                    ),
                    const SizedBox(height: KSizes.spaceBtwItems),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Obx(()=> Checkbox(value: controller.privacyPolicy.value,
                            onChanged: (value) => controller.privacyPolicy.value = !controller.privacyPolicy.value )),
                        const Text(KTexts.iAgreeTo),
                        TextButton(
                          onPressed: () => KHelper.launchUrl(AppLinks.privacy),
                          child:  Text(KTexts.privacyPolicy, style: TextStyle(color: Theme.of(context).primaryColor),),
                          ),
                        const Text(KTexts.and),
                        TextButton(
                          onPressed: () => KHelper.launchUrl(AppLinks.terms),
                          child:  Text(KTexts.termsOfUse, style: TextStyle(color: Theme.of(context).primaryColor),),
                        ),
                      ],
                    ),
                    const SizedBox(height: KSizes.spaceBtwItems),
                    //signup button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => controller.signup(),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(KSizes.md),
                        ),
                        child: const Text(KTexts.createAccount),
                      ),
                    ),
                  ],
                ),
              ),
              //divider
              const SizedBox(height: KSizes.defaultSpace),
              const PDivider(text: KTexts.orSignUpWith,),
              const SizedBox(height: KSizes.defaultSpace),
              const SocialButton(
                isSignGoogle: false,
              ),

            ],
          ),
        ),
      ),
    );
  }
}

