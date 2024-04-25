import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import 'package:knowyourself/features/mySpace/journal/model/journal_model.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:get/get.dart';

import '../../../../../../common/widgets/custom_container.dart';
import '../../../../../../utils/constants/colors.dart';
import '../../../../../../utils/constants/image_strings.dart';
import '../../../../../../utils/helpers/helper_functions.dart';
import '../../../controller/journal_controller.dart';

class JournalWidget extends StatelessWidget {
  final JournalEntry journalEntry;
  const JournalWidget({super.key, required this.journalEntry});

  @override
  Widget build(BuildContext context) {
    final controller = JournalController.instance;
    String maxCoreValue = controller.maxCoreValue();
    return GestureDetector(
      onTap: () => controller.viewJournalEntry(journalEntry),
      child: CustomContainer(
        // color: KHelper.isDarkMode(context) ? kEmptyProgressDark : kEmptyProgress,
        color: controller.getColorForCoreValue(),
        margin: const EdgeInsets.symmetric(vertical: KSizes.md),
        padding: const EdgeInsets.all(KSizes.md+KSizes.xs),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              journalEntry.content ,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: KSizes.md),
            journalEntry.imagePath != null?
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
                      return const SizedBox();
                    }
                ),
              ):
            const SizedBox(height: KSizes.zero),
            const SizedBox(height: KSizes.md),

            journalEntry.locationPath != null?
            Text(journalEntry.locationPath.toString() ,
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.labelMedium):
            const SizedBox(height: KSizes.zero),
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
                      CupertinoIcons.delete_solid,
                      size: KSizes.iconMd,
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
