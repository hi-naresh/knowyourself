import 'dart:math';

import 'package:flutter/material.dart';
import 'package:knowyourself/features/mySpace/mood/controller/add_mood_controller.dart';
import 'package:knowyourself/features/mySpace/mood/model/mood_model_old.dart';
import 'package:knowyourself/features/mySpace/mood/screens/add_mood/widgets/progress_bar.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import '../../../../../../utils/constants/colors.dart';


class ExpressFeelingsWidget extends StatefulWidget {
  const ExpressFeelingsWidget({super.key});

  @override
  State<ExpressFeelingsWidget> createState() => _ExpressFeelingsWidgetState();
}

class _ExpressFeelingsWidgetState extends State<ExpressFeelingsWidget> {
  int _selectedOptionIndex = 0; // Index of the selected option

  List<String> options = ['Social', 'Work', 'Home', 'Personal'];

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
                    SizedBox(
                      height: KSizes.defaultSpace,
                    ),
                    Text(
                      'Write down reasons for your Feelings',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(
                      height: KSizes.defaultSpace,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          optionsPlace(context, options)
                        ],
                      ),
                    ),
                    SizedBox(
                      height: KSizes.defaultSpace,
                    ),
                    Container(
                      height: 300,
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
                          // controller: journalEditorProvider.notesEditingController,
                          controller: controller.notesEditingController,
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
                      if(controller.notesEditingController.text == "") {
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
                        controller.pageController.nextPage(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                        );
                        FocusScope.of(context).unfocus();
                      }

                    },
                    child: Text("Save")
                ),
              ],
            ),
          ),
        ));
  }

  Widget optionsPlace(BuildContext context, List<String> options) {
    return Row(
      children: List.generate(options.length, (index) {
        return GestureDetector(
          onTap: () {
            setState(() {
              _selectedOptionIndex = index;
            });
          },
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 3.0),
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: _selectedOptionIndex == index ? kApp1 : Colors.grey[200],
              borderRadius: BorderRadius.circular(30.0),
              border: Border.all(
                color: _selectedOptionIndex == index ? kApp1: Colors.transparent,
                width: 2,
              ),
              boxShadow: [
                if (_selectedOptionIndex == index)
                  BoxShadow(
                    color: kApp1.withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  options[index],
                  style: TextStyle(
                    color: _selectedOptionIndex == index ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
                if (_selectedOptionIndex == index)
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                  ),
              ],
            ),
          ),
        );
      }),
    );
  }

}
