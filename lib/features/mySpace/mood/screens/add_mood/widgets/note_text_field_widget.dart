import 'package:flutter/material.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:get/get.dart';
import '../../../../../../common/widgets/linear_percent_indicator.dart';
import '../../../controller/add_mood_controller.dart';


class NotesTextFieldWidget extends StatelessWidget {
  const NotesTextFieldWidget({super.key});

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
                          //     .updateIndex(1);
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
                        "3/3",
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: KSizes.defaultSpace,
                ),
                Text(
                  "Express Your Feelings",
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                SizedBox(
                  height: KSizes.defaultSpace,
                ),
                Container(
                  height: 350,
                  width: double.infinity,
                  margin: const EdgeInsets.only(left: 10, right: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Semantics(
                    label: 'Enter journal desciption',
                    hint: 'Press to enter journal description',
                    child: TextField(
                      controller: controller.notesEditingController,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                      textAlignVertical: TextAlignVertical.top,
                      expands: true,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        fillColor: Theme.of(context).chipTheme.backgroundColor,
                        filled: true,
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
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
                onPressed: (){
                // if (journalEditorProvider.notesEditingController.text == "") {
                //         return;
                //       }
                //       JournalModel journalModel = JournalModel(
                //           journalId: (Random.secure().nextInt(90000) + 10000),
                //           createdOn: DateTime.now(),
                //           mood: Provider.of<JournalEditorProvider>(context,
                //               listen: false)
                //               .mood,
                //           title: journalEditorProvider.titleEditingController.text,
                //           color: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                //               .withOpacity(1.0),
                //           description:
                //           journalEditorProvider.notesEditingController.text, id: '');
                //       journalEditorProvider.updateJournal(journalModel);
                //       journalEditorProvider.updateIndex(3);
                },
                child: Text("Done")
            ),
          ],
        ),
      ),
    ));
  }
}
