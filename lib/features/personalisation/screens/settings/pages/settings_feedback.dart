import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../utils/constants/sizes.dart';
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
            Text("Your feedback matters.",
                style: Theme.of(context).textTheme.headlineMedium),
            const SizedBox(height: KSizes.defaultSpace),
            Text(
              "We would love to hear from you!\nPlease share your feedback with us.",
              style: Theme.of(context).textTheme.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: KSizes.defaultSpace),
            TextFormField(
              controller: controller.textController,
              onChanged: (value) => controller.setFeedback(),
              decoration: const InputDecoration(
                labelText: 'Feedback',
                hintText: 'Enter your feedback here',
              ),
              keyboardType: TextInputType.text,
              maxLines: 8,
            ),
            const SizedBox(height: 16),
            const Spacer(),
            ElevatedButton(
              onPressed: () => controller.sendFeedback(),
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
