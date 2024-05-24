import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:knowyourself/features/mySpace/journal/controller/journal_controller.dart';
import 'package:knowyourself/features/mySpace/journal/screens/journal/widgets/calendar_widget.dart';
import 'package:knowyourself/features/mySpace/journal/screens/journal/widgets/journal_widget.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/constants/text_strings.dart';

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
          child: Column(
            children: [
              const SizedBox(height: KSizes.defaultSpace),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                            text:  '${KTexts.my} ',
                            style: Theme.of(context).textTheme.headlineMedium),
                        TextSpan(
                          text: KTexts.reflections,
                          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                            color: KColors.kApp4,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Row(
                    children: [
                      SvgPicture.asset(
                        "assets/icons/entries.svg",
                        height: 20,
                        color: KColors.kApp4,
                      ),
                      const SizedBox(width: KSizes.sm),
                      Obx(
                          ()=> Text(
                          controller.getNumberOfEntries(),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(width: KSizes.sm),
                      Text(
                        KTexts.entries,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  )
                ],
              ),
              const SizedBox(height: KSizes.spaceBtwItems),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
                child: Text(
                  KTexts.reflectSubtitle,
                  textAlign: TextAlign.left,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              const SizedBox(height: KSizes.defaultSpace),
              const SizedBox(
                height: 160,
                  width: double.infinity,
                  child: CalendarWidget()),
            ],
          ),
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: KSizes.defaultSpace,
          ),
        ),
        Obx(
          () {
            List journals = controller.journalEntries;
            if (journals.isEmpty) {
              return SliverToBoxAdapter(
                  child: Padding(
                      padding: const EdgeInsets.all(KSizes.defaultSpace),
                      child: Center(
                        child: Text(
                            "${KTexts.no} ${KTexts.journal} ${KTexts.entries} !",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      )));
            } else {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: KSizes.defaultSpace),
                      child: JournalWidget(journalEntry: journals[index]),
                    );
                  },
                  childCount: journals.length,
                ),
              );
            }
          },
        ),
        const SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
          )
        ),
      ],
    );

    // return SingleChildScrollView(
    //   child :Column(
    //     children:[
    //       Row(
    //         mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           Text(
    //             "My Journal",
    //             style: Theme.of(context).textTheme.headlineMedium,
    //           ),
    //           Row(
    //             children: [
    //               SvgPicture.asset(
    //                 "assets/icons/entries.svg",
    //                 height: 20,
    //                 color: kApp4,
    //               ),
    //               const SizedBox(width: KSizes.sm),
    //               Obx(
    //                     ()=> Text(
    //                   controller.getNumberOfEntries(),
    //                   style: Theme.of(context).textTheme.titleLarge,
    //                 ),
    //               ),
    //               const SizedBox(width: KSizes.sm),
    //               Text(
    //                 "Entries",
    //                 style: Theme.of(context).textTheme.titleLarge,
    //               ),
    //             ],
    //           )
    //         ],
    //       ),
    //       const SizedBox(height: KSizes.defaultSpace),
    //        Container(
    //          clipBehavior: Clip.none,
    //           height: 160,
    //           width: double.infinity,
    //           child: CalendarWidget()),
    //       Obx(() {
    //           List journals = controller.journalEntries;
    //           if (journals.isEmpty) {
    //             return Padding(
    //                 padding: const EdgeInsets.all(KSizes.defaultSpace),
    //                 child: Center(
    //                   child: Text(
    //                     "No Journals Entries!",
    //                     style: Theme
    //                         .of(context)
    //                         .textTheme
    //                         .titleSmall,
    //                   ),
    //                 ));
    //           }else{
    //             return ListView.builder(
    //                 shrinkWrap: true,
    //                 key: const PageStorageKey('journalList'),
    //                 padding: const EdgeInsets.all(KSizes.defaultSpace),
    //                 itemCount: journals.length,
    //                 itemBuilder: (context, index) {
    //                   return JournalWidget(journalEntry: journals[index]);
    //                 },
    //             );
    //             // return JournalWidget(journalEntry: journals[1]);
    //           }
    //         },
    //       )
    //     ]
    //   )
    // );

  }
}
