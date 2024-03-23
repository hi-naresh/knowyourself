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
      height: Get.height * 0.5,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal:  KSizes.defaultSpace),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  controller.getCurrentDate(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                TextButton(onPressed: (){},
                    child: Text('Save', style: Theme.of(context).textTheme.titleLarge)
                )
              ],
            ),
            TextField(
              controller: controller.textEditingController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                hintText: 'Start writing...',
                hintStyle: TextStyle(color: Colors.grey),
                border: InputBorder.none,
              ),
            ),
            const Spacer(),
            Container(
              // color: Theme.of(context).scaffoldBackgroundColor,
              padding: const EdgeInsets.symmetric(vertical: KSizes.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(Icons.camera_outlined),
                    onPressed: ()=>controller.pickImage(),
                  ),
                  IconButton(
                    icon: Icon(Icons.camera_alt_outlined),
                    onPressed: ()=>controller.pickImage(),
                  ),
                  IconButton(
                    icon: Icon(Icons.location_on_outlined),
                    onPressed: ()=>controller.addLocation(),
                  ),
                  IconButton(
                    icon: Icon(Icons.mic_none_outlined),
                    onPressed: ()=>controller.recordVoiceNote()
                  ),
                  IconButton(
                    icon: Icon(Icons.stop_circle),
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