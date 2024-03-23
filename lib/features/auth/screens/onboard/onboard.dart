import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../routes.dart';
import '../../../../utils/constants/colors.dart';
import '../../../../utils/constants/image_strings.dart';
import '../../../../utils/constants/text_strings.dart';
import '../../../../utils/constants/sizes.dart';
import '../../controller/onboard/onboard_controller.dart';

//
// class OnBoard extends StatelessWidget {
//   const OnBoard({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final controller = Get.put(OnBoardController());
//
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(KSizes.defaultSpace*2),
//         child: Column(
//           children: [
//             Text(
//               KTexts.onBoardingTitle,
//               style: Theme.of(context).textTheme.headlineLarge?.copyWith(
//                     fontWeight: FontWeight.w800,
//                   ),
//               ),
//             const SizedBox(height:KSizes.spaceBtwItems),
//             Text(
//               KTexts.onBoardingSubtitle,
//               style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                     fontWeight: FontWeight.w400,
//                   ),
//               textAlign: TextAlign.center,
//             ),
//             const SizedBox(height:KSizes.defaultSpace*4),
//             GestureDetector(
//               onTap: () {
//                 // Get.toNamed(KRoutes.getRegisterRoute());
//                 controller.nextPage();
//               },
//               child: Text(
//                 KTexts.onBoardingTitle,
//                 style: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                       fontWeight: FontWeight.w800,
//                       color: Theme.of(context).primaryColor,
//                     ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

class OnBoard extends StatefulWidget {
  const OnBoard({super.key});

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnBoardController());

    final Text onBoardScreen1RichText = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Welcome to ',
            style : Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
            ),
          ),
          TextSpan(
            text: 'K',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: kApp2,
            ),
          ),
          TextSpan(
            text: 'now ',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: kApp3,
            ),
          ),
          TextSpan(
              text: 'Yourself ',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: kApp1,
              )
          ),
          TextSpan(
            text: 'Better\n',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
            )
          ),
          TextSpan(
              text:'Embark on a transformative journey with Know Yourself Better, unlocking the tools to illuminate the spark within.',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w400,)
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );

    final Text onBoardScreen2RichText = Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: 'Feel,',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: kApp2,
            ),
          ),
          TextSpan(
            text: 'Track,',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: kApp3,
            ),
          ),
          TextSpan(
              text: 'Thrive',
              style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                fontWeight: FontWeight.w800,
                color: kApp1,
              )
          ),
          TextSpan(
            text:   "\n\nCapture emotions, track feelings, and gain personalized insights. Empower yourself for a deeper understanding, navigating life's highs and lows.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
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
            text: 'Get Started!',
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
              fontWeight: FontWeight.w800,
              color: kApp1,
            ),
          ),
          TextSpan(
            text: "\n\nYour path to self-discovery \nawaits, let's start this empowering journey together.",
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
            )
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );

    Color buildColor() {
      if (controller.activeIndex.value == 0) {
        return kPrimaryColor;
      } else if (controller.activeIndex.value == 1) {
        return kApp2;
      }
      return kApp3;
    }

    Color buildActiveDotColor() {
      if (controller.activeIndex.value == 0) {
        return kPrimaryColor;
      } else if (controller.activeIndex.value == 1) {
        return kApp2;
      }
      return kApp3;
    }
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
                  pngName: "mental",
                  context: context),
              _buildPage(
                  richText: onBoardScreen2RichText,
                  pngName: "physical",
                  context: context),
              _buildPage(
                  richText: onBoardScreen3RichText,
                  pngName: "journalm",
                  context: context),
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
                dotWidth: 11,
                radius: 20,
                activeDotColor: buildActiveDotColor(),
                dotColor: kEmptyProgress,
              )
            ),
          ),
          Positioned(
            bottom: 50,
            child: button(
              context,
              " ",
              () {
                if (controller.activeIndex.value == 2) {
                  Get.toNamed(KRoutes.getLoginRoute());
                  return;
                }
                controller.pageController.animateToPage(
                    controller.activeIndex.value + 1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
              buildColor(),
            ),
          ),
        ],
      ),
    );
  }

  Widget button(BuildContext context, String text, Function() onPressed, Color color) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
        child: const Icon(
              Icons.chevron_right,
              color: KColors.white,
              size: KSizes.iconLg,
        ),
      ),
    );
  }

  Container _buildPage(
      {required Text richText,
        required String pngName,
        required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          SizedBox(
            height: 300,
            width: double.infinity,
            child: SvgPicture.asset(
              "assets/illustrations/$pngName.svg",
              fit: BoxFit.contain,
            ),
          ),
          const Spacer(),
          richText,
          const Spacer()
        ],
      ),
    );
  }
}

