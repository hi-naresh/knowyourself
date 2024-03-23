import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/features/mySpace/gratitude/controller/gratitude_controller.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';
import '../../../../../utils/constants/colors.dart';
import '../gratitude_screen.dart';

class GratitudeWidget extends StatelessWidget {
  const GratitudeWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GratitudeController());
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: kBoxLight,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            KTexts.gratitudeHead,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          Text(
            KTexts.gratitudeSubtext,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          GestureDetector(
            onTap: () {
              if (controller.celebrationString == "") {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (BuildContext context) {
                      return const GratitudeScreen();
                    }));
              }
            },
            child: Container(
              padding: const EdgeInsets.all(15),
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).chipTheme.secondarySelectedColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (controller.celebrationString != "")
                    Flexible(
                      child: Text(
                        controller.celebrationString,
                        maxLines: 3,
                        overflow: TextOverflow.visible,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                    ),
                  if (controller.celebrationString == "")
                    Text(
                      "I did a random act of __________.",
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  if (controller.celebrationString == "")
                    const Icon(
                      Icons.arrow_forward,
                      color: kApp4,
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}