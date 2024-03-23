import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import '../../controller/entry_controller.dart';

class JournalEntryScreen extends StatelessWidget {
  const JournalEntryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(EntryController());
    return SizedBox(
      height: Get.height * 0.7,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  KSizes.defaultSpace),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(CupertinoIcons.bookmark),
                  onPressed: ()=>controller.addBookmark(),
                ),
                Text(
                  controller.getCurrentDate(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                TextButton(onPressed: (){},
                    child: Text('Save', style: Theme.of(context).textTheme.titleLarge)
                )
              ],
            ),
            TextFormField(
              onTap: ()=>controller.deFocusKeyboard(context),
              controller: controller.textEditingController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Your reflection for today...',
                hintStyle: TextStyle(color: Colors.grey),
                contentPadding: EdgeInsets.all(KSizes.defaultSpace),
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
              ),
            ),
            const Spacer(),
            Container(
              // color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: KSizes.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(CupertinoIcons.photo_on_rectangle),
                    onPressed: ()=>controller.pickImage(),
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.camera),
                    onPressed: ()=>controller.pickImage(),
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.location_solid),
                    onPressed: ()=>controller.addLocation(),
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.waveform_path_badge_plus),
                    onPressed: ()=>controller.recordVoiceNote()
                  ),
                  IconButton(
                    icon: const Icon(CupertinoIcons.largecircle_fill_circle),
                    onPressed: ()=>controller.stopRecording(),
                  ),
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