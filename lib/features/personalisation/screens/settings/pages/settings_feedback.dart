import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../../controller/setting_controller.dart';

class SettingsFeedback extends StatelessWidget {
  const SettingsFeedback({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FeedBackController());
    return Scaffold(
      appBar: const KAppBar(back: true,),
      body: Padding(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: Column(
          children: [
            Text( KTexts.feedbackHeader,
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: KSizes.defaultSpace),
            Text(
              KTexts.feedbackDescription,
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: KSizes.defaultSpace),
            TextFormField(
              controller: controller.textController,
              onChanged: (value) => controller.setFeedback(),
              decoration: const InputDecoration(
                labelText: KTexts.feedbackTitle,
                hintText: KTexts.feedbackHint,
              ),
              keyboardType: TextInputType.text,
              maxLines: 8,
            ),
            const SizedBox(height: 16),
            const Spacer(),
            ElevatedButton(
              onPressed: () => controller.sendFeedback(),
              child: const Text(KTexts.submit),
            ),
          ],
        ),
      ),
    );
  }
}
