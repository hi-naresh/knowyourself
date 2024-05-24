import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/text_strings.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/onboard/onboard_controller.dart';

class OnBoard extends StatelessWidget {
  const OnBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardController());

    final Text onBoardScreen1RichText = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: KTexts.onBoardingTitle,
            style : Theme.of(context).textTheme.displayMedium?.copyWith(
              fontWeight: FontWeight.w800,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          TextSpan(
            text: "\n${KTexts.onBoardingTitle1[0]}",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: KColors.kApp2,
            ),
          ),
          TextSpan(
            //rest of the text
            text: KTexts.onBoardingTitle1.substring(1,5),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: KColors.kApp3,
            ),
          ),
          TextSpan(
              text: KTexts.onBoardingTitle1.substring(5,9),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: KColors.kApp4Dark,
              )
          ),
          TextSpan(
              text: KTexts.onBoardingTitle1.substring(9,13),
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: KColors.kApp3,
              )
          ),
          TextSpan(
            text: KTexts.onBoardingTitle1.substring(13),
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
            )
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );

    final Text onBoardScreen2RichText = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: KTexts.onBoardingTitle2,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w800,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );

    final Text onBoardScreen3RichText = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: KTexts.onBoardingTitle3,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: controller.pageController,
            onPageChanged: (value) => controller.activeIndex.value = value,
            children: [
              _buildPage(
                  richText: onBoardScreen1RichText,
                  subtitle: KTexts.onBoardingSubTitle,
                  pngName: "onboard1",
                  context: context,
                // color: controller.colors[0],
              ),
              _buildPage(
                  richText: onBoardScreen2RichText,
                  subtitle: KTexts.onBoardingSubTitle2,
                  pngName: "onboard2",
                  context: context,
                // color: controller.colors[1],
              ),

              _buildPage(
                  richText: onBoardScreen3RichText,
                  subtitle: KTexts.onBoardingSubTitle3,
                  pngName: "onboard3",
                  context: context,
                // color: controller.colors[2],
              ),
            ],
          ),
          Positioned(
            bottom: 150,
            child: SmoothPageIndicator(
              controller: controller.pageController,
              count: 3,
              effect: ExpandingDotsEffect(
                expansionFactor: KSizes.sm,
                dotHeight: 5,
                dotWidth: 5,
                radius: 20,
                activeDotColor: Theme.of(context).iconTheme.color!,
                dotColor: KColors.kEmptyProgress,
              )
            ),
          ),
          Positioned(
            bottom: 50,
            child: GestureDetector(
              onTap: ()=>controller.onTap(),
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                ),
                child: Icon(
                  CupertinoIcons.rocket,
                  color: Theme.of(context).scaffoldBackgroundColor,
                  size: KSizes.iconLg,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _buildPage(
      {required Text richText,
        required String subtitle,
        required String pngName,
        required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(KSizes.defaultSpace*2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 280,
            width: double.infinity,
            child: SvgPicture.asset(
              "assets/illustrations/$pngName.svg",
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(
            height: KSizes.defaultSpace*2,),
          richText,
          const SizedBox(
            height: KSizes.defaultSpace,),
          Text(
            subtitle,
            textAlign: TextAlign.justify,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
          const SizedBox(
            height: KSizes.defaultSpace*2,)
        ],
      ),
    );
  }
}

