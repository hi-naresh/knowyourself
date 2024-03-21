import 'package:flutter/material.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/sizes.dart';

class PDivider extends StatelessWidget {
  final String text;
  const PDivider({
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Expanded(
          child: Divider(
            color: KColors.borderPrimary,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
          child: Text(text),
        ),
        const Expanded(
          child: Divider(
            color: KColors.borderPrimary,
          ),
        ),
      ],
    );
  }
}
