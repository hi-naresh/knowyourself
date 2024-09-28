import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/appbar.dart';
import 'package:knowyourself/common/widgets/loading_widget.dart';
import 'package:knowyourself/features/tour/screens/tour_screen.dart';

import '../../../../../utils/constants/text_strings.dart';
import '../../../../mySpace/digdeeper/screens/digdeeper_screen.dart';
import '../../../controller/debug_controller.dart';

class DebugScreen extends StatelessWidget {
  const DebugScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(DebugController());
    return Scaffold(
      appBar: KAppBar(
        back: true,
      ),
      body: DigDeeperScreen(),
      // body: Center(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children:  <Widget>[
      //       ElevatedButton(
      //           onPressed:()=> controller.onPressed(),
      //           child: const Text(KTexts.testModel)),
      //     ],
      //   ),
      // ),
    );
    // return Center(
    //     child: SizedBox(
    //       height: Get.height,
    //       width: Get.width,
    //         child: Center(child: TourScreen())));

  }
}
