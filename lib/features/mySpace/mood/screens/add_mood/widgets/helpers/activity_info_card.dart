import 'package:flutter/material.dart';
import 'package:knowyourself/utils/constants/sizes.dart';

import '../../../../../../../common/widgets/appbar/appbar.dart';
import '../../../../../../../common/widgets/custom_container.dart';
import '../../../../../../../utils/helpers/helper_functions.dart';
import '../../../../model/activity_info_model.dart';


class ActivityInfoCard extends StatelessWidget {
  final ActivityModel activityModel;
  const ActivityInfoCard({super.key,required this.activityModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KAppBar(
        back: true,
      ),
      body: CustomContainer(
        margin: const EdgeInsets.all(KSizes.defaultSpace),
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              activityModel.title,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            //text
            const SizedBox(
              height: KSizes.spaceBtwItems,
            ),
            Text(
                "Instructions : \n\n${activityModel.instructions!}",
                style: Theme.of(context).textTheme.bodyLarge,
                textAlign: TextAlign.justify,
                // overflow: TextOverflow.ellipsis,
                // maxLines: 10,
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                KHelper.launchUrl(activityModel.link!);
              },
              child: const Text("Read more"),
            ),
          ],
        ),
      ),
    );
  }
}
