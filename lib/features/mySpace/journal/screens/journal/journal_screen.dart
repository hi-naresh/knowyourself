import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:knowyourself/features/mySpace/journal/controller/journal_controller.dart';
import 'package:knowyourself/features/mySpace/journal/screens/journal/widgets/calendar_widget.dart';
import 'package:knowyourself/features/mySpace/journal/screens/journal/widgets/journal_widget.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:get/get.dart';
import '../../../../../data/repo/space/journal/journal_repo.dart';
import '../../../../../utils/constants/colors.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JournalController());
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.all(KSizes.md),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "My Journal",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Obx(() {
                      final DateTime currentDate = controller.getDate;
                      final Future<int> entriesFuture = JournalGetStorage.getMonthNumOfEntries(currentDate);
                      return FutureBuilder<int>(
                        future: entriesFuture,
                        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                          if (snapshot.hasData) {
                            int entries = snapshot.data!;
                            return Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/entries.svg",
                                  height: 20,
                                  color: kApp4,
                                ),
                                SizedBox(width: KSizes.sm),
                                Text(
                                  entries.toString(),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                SizedBox(width: KSizes.sm),
                                Text(
                                  "Entries",
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ],
                            );
                          }
                          return const Text("..."); // Placeholder for loading or no data state
                        },
                      );
                    })
                  ],
                ),
                const SizedBox(height: KSizes.defaultSpace),
                const CalendarWidget(),
              ],
            ),
          ),
        ),
        Obx(
          () {
            List journals = controller.journals;
            if (journals.isEmpty) {
              return SliverToBoxAdapter(
                  child: Padding(
                      padding: EdgeInsets.all(KSizes.defaultSpace),
                      child: Center(
                        child: Text(
                          "No Journals Entries!",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      )));
            }
            return SliverList(
              delegate: SliverChildBuilderDelegate(
                childCount: journals.length,
                (context, index) {
                  return JournalWidget(journalModel: journals[index]);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
