import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../utils/constants/image_strings.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controller/login/login_controller.dart';

class SocialButton extends StatelessWidget {
  final bool isSignGoogle;
  const SocialButton({
    super.key, required this.isSignGoogle,
  });

  @override
  Widget build(BuildContext context) {
    final controller = LoginController.instance;
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
            Text(isSignGoogle ? KTexts.signInGoogle : KTexts.signUpGoogle),
          ],
        ),
      ),
    );
  }
}
