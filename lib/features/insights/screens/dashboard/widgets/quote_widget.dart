import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/styles/styles.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

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
      decoration: KStyles.lightToDark(
          KHelper.isDark()? kEmptyProgressDark: kEmptyProgress,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 0,
            child: SvgPicture.asset(
              colorFilter: const ColorFilter.mode(
                Colors.white54,
                BlendMode.modulate,
              ),
              KImages.health21,
              height: 105,
              fit: BoxFit.contain,
            ),
          ),
          Obx(
            (){
              if (controller.quoteModel.value == null) {
                return const CircularProgressIndicator();
              }
              return Text.rich(
                textAlign: TextAlign.right,
                strutStyle: const StrutStyle(
                  fontSize: 20.0,
                  height: 1.5,
                ),
                TextSpan(
                  children: [
                    TextSpan(
                      text: controller.quoteModel.value!.title,
                      style: Theme.of(context).textTheme.bodyLarge
                    ),
                    TextSpan(
                      text: "\n- ${controller.quoteModel.value!.author}",
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),

              );
            },
          ),
        ],
      ),
    );

  }
}
