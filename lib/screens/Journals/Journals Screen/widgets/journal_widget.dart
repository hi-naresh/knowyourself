import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:knowyourself/models/journals/journal_model.dart';
import 'package:knowyourself/provider/App%20State/app_state_provider.dart';
import 'package:knowyourself/provider/journal/journal_provider.dart';
import 'package:knowyourself/screens/Journals/View%20Journal%20Screen/view_journal_screen.dart';

class JournalWidget extends StatelessWidget {
  final JournalModel journalModel;
  const JournalWidget({super.key, required this.journalModel});

  void _opendeleteDialog({required BuildContext context}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text("Delete Journal"),
          content: const Text("Are your sure to delete this journal?"),
          actions: [
            CupertinoDialogAction(
              onPressed: () {
                Provider.of<JournalProvider>(context, listen: false)
                    .deleteJournal(journalModel: journalModel);
                Navigator.pop(context);
              },
              isDefaultAction: true,
              child: const Text("Yes"),
            ),
            CupertinoDialogAction(
              onPressed: () {
                Navigator.pop(context);
              },
              isDefaultAction: true,
              child: const Text("No"),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final appStateProvider =
        Provider.of<AppStateProvider>(context, listen: false);
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) {
              return ViewJournalScreen(
                journalModel: journalModel,
                readOnly: true,
              );
            },
          ),
        );
      },
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.25.r,
          motion: const ScrollMotion(),
          children: [
            CustomSlidableAction(
              onPressed: (BuildContext context) {
                _opendeleteDialog(context: context);
              },
              backgroundColor: Colors.transparent,
              child: Semantics(
                label: 'delete journal',
                hint: 'Press  to delete journal',
                child: Container(
                  height: 50.h,
                  width: 100.w,
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
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                DateFormat.jm().format(journalModel.createdOn),
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF868686),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              padding: const EdgeInsets.all(10),
              height: 85.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                color: Theme.of(context).cardColor,
                boxShadow: [
                  !appStateProvider.isDarkMode
                      ? const BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0.0, 4), //(x,y)
                          blurRadius: 59.0,
                        )
                      : const BoxShadow(
                          color: Color.fromRGBO(0, 0, 0, 0.25),
                          offset: Offset(0.0, 4), //(x,y)
                          blurRadius: 59.0,
                        ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 60.h,
                    height: 60.h,
                    decoration: BoxDecoration(
                      color: Theme.of(context).chipTheme.secondarySelectedColor,
                      borderRadius: const BorderRadius.all(
                        Radius.circular(10),
                      ),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        "assets/emojis/${journalModel.mood}.svg",
                        height: 40.h,
                        width: 40.h,
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
                            style: TextStyle(
                                fontSize: 16.sp, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            journalModel.description,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.w500),
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
