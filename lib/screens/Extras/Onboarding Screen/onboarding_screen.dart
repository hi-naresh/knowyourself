import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/screens/Register/LoginScreen.dart';
import 'package:knowyourself/screens/Register/SignUpInfo.dart';
import 'package:knowyourself/screens/widgets/global_styles.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:knowyourself/utils/ui_colors.dart';

import '../Avatar Select Screen/avatar_select_screen.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  static TextStyle head(Color color) => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w800,
    fontFamily: 'Poppins',
    color:color,
  );

  static TextStyle info(Color color) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    fontFamily: 'Poppins',
    color:color,
  );

  final Text onBoardScreen1RichText = Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: 'Welcome to ',
          style : head(Color(0xFF191D21)),
        ),
        TextSpan(
          text: 'K',
          style: head(Color(0xFFFF5D9C)),
        ),
        TextSpan(
          text: 'now ',
          style: head(Color(0xFF19C788)),
        ),
        TextSpan(
          text: 'Yourself ',
          style: head(Color(0xFF0086DF))
        ),
        TextSpan(
          text: 'Better\n',
          style: head(Color(0xFF191D21)),
        ),
        TextSpan(
          text:  'Embark on a transformative journey with Know Yourself Better, unlocking the tools to illuminate the spark within.',
          style: info(Color(0xFF191D21))
        ),
      ],
    ),
  );

  final Text onBoardScreen2RichText = Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: 'Feel,',
          style: head(Color(0xFFFF5D9C)),
        ),
        TextSpan(
          text: 'Track,',
          style: head(Color(0xFF19C788)),
        ),
        TextSpan(
          text: 'Thrive. ',
          style: head(Color(0xFF0086DF))
        ),
        TextSpan(
          text:   "\n\nCapture emotions, track feelings, and gain personalized insights. Empower yourself for a deeper understanding, navigating life's highs and lows.",
          style: info(Color(0xFF191D21)),
        ),
      ],
    ),
  );

  final Text onBoardScreen3RichText = Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: 'Get Started ',
          style: head(Color(0xFF0086DF)),
        ),
        TextSpan(
          text: "\n\nYour path to self-discovery \nawaits—let's start this empowering journey together.",
          style: info(const Color(0xFF191D21)),
        ),
      ],
    ),
  );

  Color _buildColor() {
    if (activeIndex == 0) {
      return kPrimaryColor;
    } else if (activeIndex == 1) {
      return kTodoPrimaryColor;
    }
    return kJournalPrimaryColor;
  }

  Color _buildActiveDotColor() {
    if (activeIndex == 0) {
      return kPrimaryColor;
    } else if (activeIndex == 1) {
      return kTodoPrimaryColor;
    }
    return kJournalPrimaryColor;
  }

  Future showBottomSheet(BuildContext context, {required Widget child}) {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFFFFE0F7),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(25),
              topRight: Radius.circular(25),
            ),
          ),
          height: 750,
          // color: Colors.white,
          child: child,
        );
      },
    );
  }

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFE4F8),
      body: Stack(
        alignment: Alignment.center,
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (value) {
              setState(() {
                activeIndex = value;
              });
            },
            children: [
              _buildPage(
                  richText: onBoardScreen1RichText,
                  pngName: "onboard1",
                  context: context),
              _buildPage(
                  richText: onBoardScreen2RichText,
                  pngName: "onboard2",
                  context: context),
              _buildPage(
                  richText: onBoardScreen3RichText,
                  pngName: "getstarted",
                  context: context),
            ],
          ),
          Positioned(
            bottom: 150,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: 3,
              effect: WormEffect(
                dotHeight: 11,
                dotWidth: 11,
                radius: 20,
                activeDotColor: _buildActiveDotColor(),
                dotColor: const Color(0xFFD0D0D0),
              ),
            ),
          ),
          Positioned(
            bottom: 50,
            child: GestureDetector(
              onTap: () {
                if (activeIndex == 2) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (BuildContext context) {
                    return const AvatarSelectScreen();
                    // return const LoginScreen();
                  }));

                  return;
                }
                _pageController.animateToPage(activeIndex + 1,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear);
              },
              child: (activeIndex == 2) ?
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      button(context, 'Sign In', () => showBottomSheet(context, child: const LoginScreen())),
                      SizedBox(width: 20.w,),
                      button(context, 'Sign Up', () => showBottomSheet(context, child: const SignupInfoScreen())),
                    ],
                  )
                  :
              Container(
                height: 60.h,
                width: 60.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _buildColor(),
                ),
                child: Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: 40.r,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button(BuildContext context, String text, Function() onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 120.w,
        height: 50.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: _buildColor(),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
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
          SizedBox(
            height: 350.h,
            width: double.infinity,
            child: Image.asset(
              "assets/illustrations/$pngName.png",
              fit: BoxFit.contain,
            ),
          ),
          richText,
          const Spacer()
        ],
      ),
    );
  }
}
