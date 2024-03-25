import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:knowyourself/features/mySpace/journal/model/journal_model.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/custom_container.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controller/journal_controller.dart';

class JournalWidget extends StatelessWidget {
  final JournalEntry journalEntry;
  const JournalWidget({super.key, required this.journalEntry});

  @override
  Widget build(BuildContext context) {
    final controller = JournalController.instance;
    return CustomContainer(
      color: KHelper.isDarkMode(context) ? kEmptyProgressDark : kEmptyProgress,
      margin: const EdgeInsets.symmetric(vertical: KSizes.md),
      padding: const EdgeInsets.all(KSizes.md+KSizes.xs),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            journalEntry.content,
            softWrap: true,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.jm().format(journalEntry.entryDate),
                style: Theme.of(context).textTheme.labelMedium,
              ),
              IconButton(
                  onPressed: ()=>controller.deleteJournalEntry(journalEntry.id),
                  icon: const Icon(
                      CupertinoIcons.delete_left_fill,
                    size: KSizes.iconMd,
                  )),
            ],
          ),
          const SizedBox(height: KSizes.md),
          if (journalEntry.imagePath != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(KSizes.borderRadiusXl),
              clipBehavior: Clip.antiAlias,
              child: Image(
                  image: AssetImage(journalEntry.imagePath.toString()),
                  width: double.infinity,
                  height: Get.height * 0.15,
                  fit: BoxFit.cover,
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return Icon(CupertinoIcons.photo,size:Get.height * 0.15 ,);
                  }
              ),
            ),
          const SizedBox(height: KSizes.md),
          if (journalEntry.locationPath != null)
            Text(journalEntry.locationPath.toString() ,
                textAlign: TextAlign.right,
                style: Theme.of(context).textTheme.labelMedium),
        ],
      ),
    );
  }
}
