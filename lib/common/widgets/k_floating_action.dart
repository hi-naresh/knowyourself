import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowyourself/features/mySpace/journal/screens/journal_entry/journal_entry.dart';

import '../../../common/styles/styles.dart';
import '../../../utils/constants/colors.dart';
import '../../utils/constants/sizes.dart';
import '../../utils/helpers/helper_functions.dart';

class KFloatingAction extends StatelessWidget {
  const KFloatingAction({
    super.key,
    required this.context,
  });

  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: KSizes.iconXl * 2,
      width: KSizes.iconXl * 2,
      decoration: KStyles.darkToLight(kApp4),
      child: IconButton(
        icon: Icon(
          CupertinoIcons.book,
          size: KSizes.iconLg,
          color: Theme.of(context).textTheme.titleMedium!.color,
        ),
        onPressed: () {
          KHelper.showBottomSheet(const JournalEntryScreen());
        },
      ),
    );
  }
}
