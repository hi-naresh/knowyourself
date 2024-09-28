import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/digdeeper/screens/shape_handler.dart';
import 'package:knowyourself/features/mySpace/digdeeper/screens/shape_painter_forces.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../controller/digdeeper_controller.dart';


class SoulForcesWidget extends StatelessWidget {
  SoulForcesWidget({super.key});

  final ShapeHandler _shapeHandler = ShapeHandler();
  final DigDeeperController controller = Get.put(DigDeeperController());


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
      child: Column(
        children: [
          const Text(
            "Soul Forces",
            style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.w700
            ),
          ),
          Text(
              "These are 4 soul forces which drvies the life from inside out."
          ),
          // const SizedBox(height: KSizes.defaultSpace*5,),
          GestureDetector(
            onTapUp: (details) {
              final String? tappedShape =
              _shapeHandler.getTappedShape(details.localPosition);

              if (tappedShape != null) {
                controller.handleTap(tappedShape);
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                Obx(
                      () => CustomPaint(
                    size: const Size(320, 320),
                    painter: ShapePainterForces(
                      currentShapeIndex: controller.currentShapeIndex.value,
                      scaleAnimation: controller.scaleAnimation,
                      labels: controller.labels,
                    ),
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
