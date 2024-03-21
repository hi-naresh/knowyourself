import 'package:flutter/material.dart';

import '../../../../../common/widgets/my_card.dart';
import '../../../../../utils/constants/colors.dart';
import '../../../../../utils/device/device_utility.dart';
import '/utils/constants/sizes.dart';

class MyselfSection extends StatelessWidget {
  const MyselfSection({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Myself", style: Theme.of(context).textTheme.headlineSmall),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "View All",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: KSizes.md),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            myCard(
              context: context,
              title: "Journal",
              color: kApp1,
              imageUrl: "assets/illustrations/journalm.svg",
              screenWidth: KDeviceUtils.getScreenWidth(context),
            ),
            myCard(
              context: context,
              title: "Review",
              color: kApp2,
              imageUrl: "assets/illustrations/review.svg",
              screenWidth: KDeviceUtils.getScreenWidth(context),
            ),
          ],
        ),
      ],
    );
  }

  Widget myCard({
    required BuildContext context,
    required String title,
    required Color color,
    required String imageUrl,
    required double screenWidth,
  }) {
    return GestureDetector(
      onTap: () {},
      child: MyCard(
        width: screenWidth * 0.4,
        height: KSizes.hCardSmall,
        left: screenWidth * 0.2,
        title: title,
        color: color,
        imageUrl: imageUrl,
      ),
    );
  }
}
