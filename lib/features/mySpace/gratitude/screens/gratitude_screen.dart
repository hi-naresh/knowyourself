import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:knowyourself/features/mySpace/gratitude/screens/widgets/gratitude_title.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';

import '../../../../common/widgets/appbar/appbar.dart';
import '../controller/gratitude_controller.dart';
import '../model/gratitude_model.dart';


class GratitudeScreen extends StatelessWidget {
  const GratitudeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = GratitudeController.instance;
    return Scaffold(
      appBar: const KAppBar(back: true,),
      body: Padding(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              KTexts.gratitudeHead,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 0, left: 20, right: 20),
              child: Text(
                DateFormat.yMMMMEEEEd().format(
                  DateTime.now(),
                ),
                style:Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const SizedBox(
              height: KSizes.defaultSpace,
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: controller.gratitudeModel.value.title,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  WidgetSpan(
                    child: SizedBox(
                      height: 70,
                      child: TextField(
                        maxLines: 1,
                        maxLength: 50,
                        controller: controller.celebrationTextEditingController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          fillColor: Theme.of(context)
                              .chipTheme
                              .backgroundColor,
                          filled: true,
                          enabledBorder: const UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: kApp4),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide:
                            BorderSide(color: kApp4),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              // width: double.infinity,
              margin:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.all(
                  Radius.circular(20),
                ),
                boxShadow: const [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                    offset: Offset(0.0, 4), //(x,y)
                    blurRadius: 38.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    KTexts.moreReasonsToCelebrate,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: KSizes.defaultSpace,
                  ),
                  GratitudeTitle(
                    gratitudeModel: GratitudeModel(
                      title: KTexts.quitBadHabit,
                    ),
                  ),
                  GratitudeTitle(
                    gratitudeModel:
                    GratitudeModel(
                      title: KTexts.thankfulFor,
                    ),
                  ),
                  GratitudeTitle(
                    gratitudeModel: GratitudeModel(
                      title: KTexts.continuedTo,
                    ),
                  ),
                  GratitudeTitle(
                    gratitudeModel: GratitudeModel(
                      title: KTexts.actOfKindness,
                    ),
                  ),
                  GratitudeTitle(
                    gratitudeModel: GratitudeModel(
                      title: KTexts.startedHabit,
                    ),
                  ),
                  GratitudeTitle(
                    gratitudeModel: GratitudeModel(
                      title: KTexts.randomAct,
                    ),
                  ),
                  GratitudeTitle(
                    gratitudeModel: GratitudeModel(
                      title: KTexts.gratefulFor,
                    ),
                  ),
                ],
              ),
            ),
            const Expanded(child: SizedBox()),
            // Consumer<CelebrationProvider>(
            //   builder: (BuildContext context, value, Widget? child) {
            //     return Center(
            //       child: InkWell(
            //         onTap: () {
            //           if (value.celebrationTextEditingController.text != "") {
            //             value.saveCelebrationString();
            //             int imageIndex = Random().nextInt(9);
            //             StatusModel statusModel = StatusModel(
            //                 title: value.celebrationString,
            //                 image: "bg$imageIndex.jpg",
            //                 dateTime: DateTime.now(),
            //                 hasSeen: false,
            //                 statustype: Statustype.celebrate);
            //             Provider.of<StatusProvider>(context, listen: false)
            //                 .addStatus(statusModel: statusModel);
            //             Navigator.pop(context);
            //           }
            //         },
            //         child: Container(
            //           padding: const EdgeInsets.all(10),
            //           margin: const EdgeInsets.all(20),
            //           width: double.infinity,
            //           height: 50.h,
            //           decoration: BoxDecoration(
            //             color: const Color(0xFFFFDABF),
            //             borderRadius: BorderRadius.circular(40),
            //           ),
            //           child: Center(
            //             child: Text(
            //               "Celebrate",
            //               style: TextStyle(
            //                 fontSize: 13.sp,
            //                 color: kTodoPrimaryColor,
            //                 fontWeight: FontWeight.w500,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            // )
            ElevatedButton(onPressed: (){},
              child: const Text(KTexts.celebrate),
            )
          ],
        ),
      ),
    );
  }
}