import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../../controller/entry_controller.dart';

class JournalEntryScreen extends StatelessWidget {
  const JournalEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EntryController());
    return SizedBox(
      height: Get.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(
                    CupertinoIcons.bookmark,
                    color: KColors.kApp4,
                  ),
                  onPressed: () => controller.addBookmark(),
                ),
                Text(
                  controller.getCurrentDate(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextButton(
                    onPressed: ()=>controller.cancelEntry(),
                    child: Text( KTexts.cancel,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: KColors.kApp4
                        )))
              ],
            ),
            const SizedBox(height: KSizes.defaultSpace),
            Obx(() {
              if (controller.location.value.isNotEmpty) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(controller.location.value,
                        style: Theme.of(context).textTheme.labelMedium),
                    IconButton(
                      icon: const Icon(CupertinoIcons.restart),
                      onPressed: () => controller.updateLocation(),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
            Obx(() {
              if (controller.selectedImage.value != null) {
                return Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(KSizes.borderRadiusXl),
                      child: Image.file(File(controller.selectedImage.value!.path),
                          height: Get.height * 0.2, width: Get.width * 0.9,
                          fit: BoxFit.cover
                      ),
                    ),
                    IconButton(
                      icon: const Icon(CupertinoIcons.delete_left),
                      onPressed: () => controller.removeSelectedImage(),
                    ),
                  ],
                );
              } else {
                return const SizedBox();
              }
            }),
            Expanded(
              child: TextFormField(
                onTap: () => controller.deFocusKeyboard(context),
                controller: controller.textEditingController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  hintText: KTexts.dailyReflection,
                  hintStyle: TextStyle(color: KColors.grey),
                  contentPadding: EdgeInsets.all(KSizes.sm),
                  disabledBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: KSizes.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.photo_on_rectangle),
                    onPressed: () => controller.pickImage(),
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.camera),
                    onPressed: () => controller.openCamera(),
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.location_solid),
                    onPressed: () => controller.addLocation(),
                  ),
                  FilledButton(
                    style: const ButtonStyle().copyWith(
                      backgroundColor: WidgetStateProperty.all(KColors.kApp4),
                      foregroundColor: WidgetStateProperty.all(Colors.white)
                    ),
                      onPressed: (){
                        controller.saveJournalEntry();
                        Get.back();
                      },
                      child: const Text(KTexts.save,))
                  // IconButton(
                  //     icon: const Icon(CupertinoIcons.waveform_path_badge_plus),
                  //     onPressed: () => controller.recordVoiceNote()),
                  // IconButton(
                  //   icon: const Icon(CupertinoIcons.largecircle_fill_circle),
                  //   onPressed: () => controller.stopRecording(),
                  // ),
                ],
              ),
            ),
            // Display hint questions for reflections here...
          ],
        ),
      ),
    );
  }
}
