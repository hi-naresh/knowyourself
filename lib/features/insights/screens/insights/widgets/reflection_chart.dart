import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controller/insights_controller.dart';
import '../../../model/core_values.dart';
import 'reflection_painter.dart';

class ReflectionChart extends StatelessWidget {
  final double strokeWidth;
  final Color strokeColor;

  const ReflectionChart({
    super.key,
    this.strokeWidth = 4.0,
    this.strokeColor =KColors.transparent,
  });

  @override
  Widget build(BuildContext context) {
    final InsightsController controller = Get.find();

    return AnimatedBuilder(
      animation: controller.animationController, // Use controller's animation
      builder: (context, child) {
        // Use the reactive analyzedCoreValues list directly
        return Obx(() {
          final coreValues = controller.analyzedCoreValues;
          // assert(coreValues.isNotEmpty, KTexts.emptyCoreValuesErrorMessage );

          // Map animations to core values for the painter
          final animatedCoreValues = List.generate(coreValues.length, (index) => CoreValue(
            name: coreValues[index].name,
            percentage: controller.animations.isNotEmpty ? controller.animations[index].value : 0,
          ));

          return CustomPaint(
            size: const Size(300, 300), // Adjust the size as needed
            painter: ReflectionPainter(
              strokeWidth: strokeWidth,
              strokeColor: strokeColor,
              coreValues: animatedCoreValues,
            ),
          );
        });
      },
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import '../../../../../utils/constants/colors.dart';
// import '../../../../../utils/constants/text_strings.dart';
// import '../../../controller/insights_controller.dart';
// import '../../../model/core_values.dart';
// import 'reflection_painter.dart';
//
// class ReflectionChart extends StatelessWidget {
//   final double strokeWidth;
//   final Color strokeColor;
//
//   const ReflectionChart({
//     super.key,
//     this.strokeWidth = 4.0,
//     this.strokeColor = KColors.transparent,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final InsightsController controller = Get.find();
//
//     return Obx(() {
//       final coreValues = controller.analyzedCoreValues;
//
//       if (coreValues.isEmpty) {
//         return Container(
//           alignment: Alignment.center,
//           child: Text(KTexts.emptyCoreValuesErrorMessage),
//         );
//       }
//
//       final animatedCoreValues = List.generate(coreValues.length, (index) => CoreValue(
//         name: coreValues[index].name,
//         percentage: controller.animations.isNotEmpty ? controller.animations[index].value : 0,
//       ));
//
//       return AnimatedBuilder(
//         animation: controller.animationController,
//         builder: (context, child) {
//           return CustomPaint(
//             size: const Size(300, 300),
//             painter: ReflectionPainter(
//               strokeWidth: strokeWidth,
//               strokeColor: strokeColor,
//               coreValues: animatedCoreValues,
//             ),
//           );
//         },
//       );
//     });
//   }
// }
