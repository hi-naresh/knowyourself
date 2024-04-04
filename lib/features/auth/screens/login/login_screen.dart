import 'package:flutter/material.dart';
import '/features/auth/screens/login/widgets/social_button.dart';
import '/features/auth/screens/login/widgets/login_form.dart';
import '/features/auth/screens/login/widgets/p_login_header.dart';
import '/features/auth/screens/login/widgets/pdividier.dart';
import '../../../../utils/constants/sizes.dart';

import '../../../../utils/constants/text_strings.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  const Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(KSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              PLoginHeader(),
              SizedBox(height: KSizes.defaultSpace),
              //form
              PLoginForm(),
              //divider
              SizedBox(height: KSizes.defaultSpace),
              PDivider( text: KTexts.orSignInWith,),
              SizedBox(height: KSizes.defaultSpace),
              SocialButton(
                isSignGoogle: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
