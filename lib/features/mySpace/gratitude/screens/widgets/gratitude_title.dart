import 'package:flutter/material.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../controller/gratitude_controller.dart';
import '../../model/gratitude_model.dart';

class GratitudeTitle extends StatelessWidget {
  final GratitudeModel gratitudeModel;
  const GratitudeTitle({super.key, required this.gratitudeModel});

  @override
  Widget build(BuildContext context) {
    final controller = GratitudeController.instance;
    return GestureDetector(
      onTap: ()=>controller.updateCelebration(gratitudeModel),
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, top: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!(gratitudeModel.title == controller.gratitudeModel.value.title))
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    color: Color(0xFFD9D9D9), shape: BoxShape.circle),
              ),
            if ((gratitudeModel.title == controller.gratitudeModel.value.title))
              Container(
                height: 20,
                width: 20,
                decoration: const BoxDecoration(
                    color: KColors.kApp4, shape: BoxShape.circle),
                child: Center(
                  child: Container(
                    height: 12,
                    width: 12,
                    decoration: const BoxDecoration(
                        color: Color(0xFFFFB47E), shape: BoxShape.circle),
                    child: Center(
                      child: Container(
                        height: 4,
                        width: 4,
                        decoration: const BoxDecoration(
                            color: KColors.white, shape: BoxShape.circle),
                      ),
                    ),
                  ),
                ),
              ),
            const SizedBox(
              width: KSizes.defaultSpace,
            ),
            Text(
              gratitudeModel.title,
              style:Theme.of(context).textTheme.bodyMedium,
            )
          ],
        ),
      ),
    );
  }
}
