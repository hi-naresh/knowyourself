import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controller/login/login_controller.dart';

class SocialButton extends StatelessWidget {
  const SocialButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LoginController());
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: () => controller.signInWithGoogle(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              KImages.google,
              height: 20,
            ),
            const SizedBox(width: KSizes.spaceBtwItems),
            const Text(KTexts.signInGoogle),
          ],
        ),
      ),
    );
  }
}
