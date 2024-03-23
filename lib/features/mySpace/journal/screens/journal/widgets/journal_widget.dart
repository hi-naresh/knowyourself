import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/features/mySpace/journal/controller/journal_controller.dart';

import 'package:knowyourself/features/mySpace/journal/model/journal_model.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

import '../../../../../../utils/constants/colors.dart';

class JournalWidget extends StatelessWidget {
  final JournalModel journalModel;
  const JournalWidget({super.key, required this.journalModel});

  void _opendeleteDialog({required JournalModel journalModel}) {
    Get.dialog(
      CupertinoAlertDialog(
        title: const Text("Delete Journal"),
        content: const Text("Are your sure to delete this journal?"),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              // Assuming your JournalController is accessible and has a deleteJournal method
              final controller = Get.put(JournalController());
              controller.deleteJournal(journalModel: journalModel);
              Get.back(); // GetX method to close dialogs or navigate back
            },
            isDefaultAction: true,
            child: const Text("Yes"),
          ),
          CupertinoDialogAction(
            onPressed: () {
              Get.back(); // GetX method to close dialogs or navigate back
            },
            isDefaultAction: true,
            child: const Text("No"),
          )
        ],
      ),
      barrierDismissible: false, // Set to false if you want to force a choice
    );
  }

  @override
  Widget build(BuildContext context) {
    final appStateProvider =
    //dymaic - AppState Provider
        Provider.of<dynamic>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              // return MoodSummaryScreen(
              //   journalModel: journalModel,
              //   readOnly: true,
              // );
              return Container();
            },
          ),
        );
      },
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.25,
          motion: const ScrollMotion(),
          children: [
            CustomSlidableAction(
              onPressed: (BuildContext context) {
                // _opendeleteDialog();
              },
              backgroundColor: Colors.transparent,
              child: Semantics(
                label: 'delete journal',
                hint: 'Press  to delete journal',
                child: Container(
                  height: 50,
                  width: 100,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.red),
                  child: const Icon(CupertinoIcons.delete),
                ),
              ),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(
                DateFormat.jm().format(journalModel.createdOn),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF868686),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(20),
              height: 85,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                color: kBoxLight,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).chipTheme.secondarySelectedColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/emojis/${journalModel.mood}.svg",
                        height: 40,
                        width: 40,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            journalModel.title,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            journalModel.description,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: const TextStyle(
                                fontSize: 10, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.chevron_right,
                    size: 30,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
