import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/styles/styles.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../../../common/widgets/custom_container.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/image_strings.dart';
import '../../../controller/quote_controller.dart';

class QuoteWidget extends StatelessWidget {
  const QuoteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(QuoteController());
    return Container(
      padding: const EdgeInsets.all(KSizes.md),
      // decoration: KStyles.lightToDark(
      //     KHelper.isDark()? kEmptyProgressDark: kEmptyProgress,
      // ),
      // color: KHelper.isDark() ? kEmptyProgressDark : kEmptyProgress,
      decoration: BoxDecoration(
        color: kApp1.withOpacity(0.3),
        borderRadius: BorderRadius.circular(KSizes.lg),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            child: SvgPicture.asset(
              colorFilter: const ColorFilter.mode(
                Colors.white70,
                BlendMode.modulate,
              ),
              KImages.health21,
              height: 82,
              fit: BoxFit.cover,
            ),
          ),
          Obx(
            (){
              if (controller.quoteModel.value == null) {
                return const CircularProgressIndicator();
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    textAlign: TextAlign.end,
                    controller.quoteModel.value!.title,
                    style: Theme.of(context).textTheme.labelSmall?.copyWith(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const SizedBox(height: KSizes.sm),
                  Text(
                    "- ${controller.quoteModel.value!.author}",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),)
                ],
              );
            },
          ),
        ],
      ),
    );

  }
}
