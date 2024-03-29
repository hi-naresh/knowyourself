import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/features/mySpace/journal/model/journal_model.dart';
import 'package:knowyourself/utils/constants/sizes.dart';


import 'package:get/get.dart';

import '../../../../../common/widgets/appbar/appbar.dart';

class JournalEntryView extends StatelessWidget {
  final JournalEntry journalEntry;
  const JournalEntryView({super.key, required this.journalEntry});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KAppBar(back: true,),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (journalEntry.imagePath != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(KSizes.borderRadiusXl),
                  clipBehavior: Clip.antiAlias,
                  child: Image(
                      image: AssetImage(journalEntry.imagePath.toString()),
                      width: double.infinity,
                      height: Get.height * 0.25,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return const SizedBox();
                      }
                  ),
                ),
              const SizedBox(height: KSizes.defaultSpace),
              Text(
                DateFormat.yMMMMd().format(
                  DateTime.parse(
                    journalEntry.entryDate.toString(),
                  ),
                ),
                style: Theme.of(context).textTheme.labelLarge,
              ),
              if (journalEntry.locationPath != null)
                Text(journalEntry.locationPath.toString() ,
                    textAlign: TextAlign.right,
                    style: Theme.of(context).textTheme.labelMedium),
              const SizedBox(height: KSizes.defaultSpace),
              Text(
                journalEntry.content.toString(),
                maxLines: 20,
                style : Theme.of(context).textTheme.bodyMedium,
              ),


            ],
          ),
        ),
      ),
    );
  }
}
