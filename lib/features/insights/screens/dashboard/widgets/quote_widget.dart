import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/styles/styles.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

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
      decoration: KStyles.lightToDark(kApp1),
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
              height: 88,
              fit: BoxFit.contain,
            ),
          ),
          Obx(
            ()=> Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text.rich(
                  textAlign: TextAlign.right,
                  strutStyle: const StrutStyle(
                    fontSize: 20.0,
                    height: 1.2,
                  ),
                  TextSpan(
                    children: [
                      TextSpan(
                        text: controller.quoteModel.value!.title,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      TextSpan(
                        text: "\n- ${controller.quoteModel.value!.author}",
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),

                ),
              ],
            ),
          ),
        ],
      ),
    );

  }
}
