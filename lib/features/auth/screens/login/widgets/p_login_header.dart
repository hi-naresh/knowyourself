import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';

import '../../../../../utils/constants/image_strings.dart';

class PLoginHeader extends StatelessWidget {
  const PLoginHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(
          KImages.loginImage,
          width: 250,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 20),
        Text(
          KTexts.loginTitle,
          style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
              ),
        ),
      ],
    );
  }
}
