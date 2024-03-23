
import 'package:flutter/material.dart';
import 'package:knowyourself/features/mySpace/mood/controller/add_mood_controller.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/helpers/progress_bar.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/device/device_utility.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import '../../../../../../utils/constants/colors.dart';


class ExpressFeelingsPage extends StatelessWidget {
  const ExpressFeelingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AddMoodController());
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height * 0.93,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const ProgressBar(steps: "3/3", percent: 1,),
                    const SizedBox(
                      height: KSizes.defaultSpace,
                    ),
                    Text(
                      'Write down reasons for your Feelings',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(
                      height: KSizes.defaultSpace,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Obx(
                          ()=> Row(
                          children: List.generate(controller.happenedAt.length, (index) {
                            return GestureDetector(
                              onTap: ()=>controller.selectHappenedAt.value = index,
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 3.0),
                                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
                                decoration: BoxDecoration(
                                  color: controller.selectHappenedAt.value == index ? kApp1 : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(30.0),
                                  border: Border.all(
                                    color: controller.selectHappenedAt.value == index ? kApp1: Colors.transparent,
                                    width: 2,
                                  ),
                                  boxShadow: [
                                    if (controller.selectHappenedAt.value == index)
                                      BoxShadow(
                                        color: kApp1.withOpacity(0.5),
                                        spreadRadius: 1,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      controller.happenedAt[index],
                                      style: TextStyle(
                                        color: controller.selectHappenedAt.value == index ? Colors.white : Colors.black,
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (controller.selectHappenedAt.value == index)
                                      const Icon(
                                        Icons.check_circle,
                                        color: Colors.white,
                                      ),
                                  ],
                                ),
                              ),
                            );
                          }),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: KSizes.defaultSpace,
                    ),
                    Container(
                      height: KDeviceUtils.getScreenHeight() * 0.5,
                      width: double.infinity,
                      margin: const EdgeInsets.only(left: 10, right: 10),
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      ),
                      child: Semantics(
                        label: 'Enter journal desciption',
                        hint: 'Press to enter journal description',
                        child: TextField(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          controller: controller.reasons,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.newline,
                          textAlignVertical: TextAlignVertical.top,
                          expands: true,
                          decoration:  InputDecoration(
                            contentPadding: const EdgeInsets.all(20),
                            // fillColor: Theme.of(context).chipTheme.backgroundColor,
                            fillColor: kBoxLight,
                            filled: true,
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(25)),
                              borderSide: BorderSide.none,
                            ),
                            hintText: "Express Your Feelings",
                          ),
                          maxLines: null,
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    onPressed: () {
                      // if (journalEditorProvider.notesEditingController.text == "") {
                      //   return;
                      // }
                      // JournalModel journalModel = JournalModel(
                      //     journalId: (Random.secure().nextInt(90000) + 10000),
                      //     createdOn: DateTime.now(),
                      //     mood: Provider.of<JournalEditorProvider>(context,
                      //         listen: false)
                      //         .mood,
                      //     title: journalEditorProvider.titleEditingController.text,
                      //     color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                      //         .withOpacity(1.0),
                      //     description:
                      //     journalEditorProvider.notesEditingController.text,
                      //     id: '');
                      // journalEditorProvider.updateJournal(journalModel);
                      // journalEditorProvider.updateIndex(3);
                      // FocusScope.of(context).unfocus();
                      if(controller.reasons.text == "") {
                        KHelper.showSnackBar("Please input reasons","In order to understand your mood better" );
                      }else{
                        // MoodModel moodModel = MoodModel(
                        //     id: (Random.secure().nextInt(90000) + 10000).toString(),
                        //     createdOn: DateTime.now(),
                        //     mood: controller.mood.value,
                        //     aspect: controller.aspect.value,
                        //     description: controller.notesEditingController.text,
                        //     happenedAt: "Home");
                        // controller.updateJournal(moodModel);
                        controller.nextPage();
                        FocusScope.of(context).unfocus();
                      }

                    },
                    child: const Text("Save")
                ),
              ],
            ),
          ),
        ));
  }
}
