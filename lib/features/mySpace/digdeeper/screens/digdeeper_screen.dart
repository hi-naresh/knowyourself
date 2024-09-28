import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/common/widgets/appbar/appbar.dart';
import 'package:knowyourself/features/mySpace/digdeeper/screens/soul_forces_widget.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';
import '../../../../routes.dart';

class DigDeeperScreen extends StatelessWidget {

  const DigDeeperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  KAppBar(
        title: "Dig Deeper",
        back: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(height: KSizes.xs,),
          SoulForcesWidget(),
          Padding(
            padding: const EdgeInsets.all(KSizes.defaultSpace),
            child: ElevatedButton(
                onPressed: ()=> Get.offAllNamed(KRoutes.getMasterRoute()),
                child: const Text(KTexts.close)),
          )
        ],
      )
    );
  }
}

