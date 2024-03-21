import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../../../common/widgets/linear_percent_indicator.dart';
import '../../../controller/add_mood_controller.dart';

class TitleTextFieldWidget extends StatelessWidget {
  const TitleTextFieldWidget({super.key});

  String _buildTitleText(String mood) {
    if (mood == "happy") {
      return "Super happy to hear that! Tell me everything";
    } else if (mood == "loving") {
      return "Ah, someone is on cloud nine. Excited to hear your story!";
    } else if (mood == "sad") {
      return "Did anything make you feel frustrated? I'm all ears.";
    } else if (mood == "rofl") {
      return "I'm happy to laugh with you! ";
    } else if (mood == "worried") {
      return "What do you think is making you feel so bad right now?";
    } else if (mood == "joyful") {
      return "What made you smile today? ";
    } else if (mood == "relieved") {
      return "Great! Tell me.";
    } else if (mood == "neutral") {
      return "Sometimes it's okay not to be okay. I'm here if you want to share anything. ";
    } else if (mood == "confused") {
      return "You can tell me what's on your mind now; I won't judge you. ";
    } else if (mood == "crying") {
      return "Would you like to talk about it? I would happily listen to you. ";
    } else if (mood == "amazed") {
      return "What made you go like WOOOW! ";
    } else if (mood == "hungry") {
      return "We are on the same (plate) boat! ";
    } else if (mood == "angry") {
      return "You have your Space :) You can vent out here ";
    } else if (mood == "sick") {
      return "Hey, you'll be fine. How do you feel right now?";
    }
    return "Oh! I See, Let's talk about it.";
  }

  @override
  Widget build(BuildContext context) {
    // JournalEditorProvider journalEditorProvider =
    //     Provider.of<JournalEditorProvider>(context, listen: false);
    final controller = Get.put(AddMoodController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.9,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: LinearPercentIndicator(
                      alignment: MainAxisAlignment.spaceBetween,
                      leading: GestureDetector(
                        onTap: () {
                          // Provider.of<JournalEditorProvider>(context,
                          //         listen: false)
                          //     .updateIndex(0);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          size: KSizes.iconLg,
                        ),
                      ),
                      barRadius: const Radius.circular(20),
                      lineHeight: KSizes.sm,
                      width: 200,
                      percent: 1,
                      backgroundColor: const Color(0xFFD9D9D9),
                      progressColor: const Color(0xFF5349DB),
                      trailing: Text(
                        "2/3",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: KSizes.defaultSpace,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Text(
                        _buildTitleText(controller.mood.value),
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                    SizedBox(
                      height: KSizes.defaultSpace,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: TextField(
                        controller: controller.titleEditingController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.all(20),
                          fillColor:
                              Theme.of(context).chipTheme.backgroundColor,
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: BorderSide.none,
                          ),
                          hintText: "Title",
                        ),
                        maxLength: 50,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                // if (journalEditorProvider.titleEditingController.text != "") {
                //   journalEditorProvider.updateIndex(2);
                // }
              },
              child: const Text("Next"),
            ),
          ],
        ),
      ),
    ));
  }
}
