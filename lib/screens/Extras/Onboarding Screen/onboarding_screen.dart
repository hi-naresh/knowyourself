import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/screens/Register/LoginScreen.dart';
import 'package:knowyourself/screens/Register/SignUpInfo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:knowyourself/screens/Extras/Avatar%20Select%20Screen/avatar_select_screen.dart';
import 'package:knowyourself/utils/ui_colors.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  final Text onBoardScreen1RichText = Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: "Express Your ",
          style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.w600),
        ),
        TextSpan(
          text: "Feelings ",
          style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              height: 1.2,
              color: kPrimaryColor),
        ),
        TextSpan(
          text: "and Create Your ",
          style: TextStyle(
              fontSize: 28.sp, fontWeight: FontWeight.w600, height: 1.2),
        ),
        TextSpan(
          text: "Entries ",
          style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: kPrimaryColor,
              height: 1.2),
        ),
      ],
    ),
  );

  final Text onBoardScreen3RichText = Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: "Keep a record upon your ",
          style: TextStyle(
              fontSize: 28.sp, fontWeight: FontWeight.w600, height: 1.2),
        ),
        TextSpan(
          text: "achievements ",
          style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: kJournalPrimaryColor,
              height: 1.2),
        ),
        TextSpan(
          text: "and celebrate ",
          style: TextStyle(
              fontSize: 28.sp, fontWeight: FontWeight.w600, height: 1.2),
        ),
      ],
    ),
  );

  final Text onBoardScreen2RichText = Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: "Add & keep a check upon your ",
          style: TextStyle(
              fontSize: 28.sp, fontWeight: FontWeight.w600, height: 1.2),
        ),
        TextSpan(
          text: "daily task ",
          style: TextStyle(
              fontSize: 28.sp,
              fontWeight: FontWeight.w600,
              color: kTodoPrimaryColor,
              height: 1.2),
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

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  svgName: "onboard1",
                  context: context),
              _buildPage(
                  richText: onBoardScreen2RichText,
                  svgName: "onboard2",
                  context: context),
              _buildPage(
                  richText: onBoardScreen3RichText,
                  svgName: "onboard3",
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
                    // return const AvatarSelectScreen();
                    return LoginScreen();
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
                      button(context, 'Login', () => Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()))),
                      SizedBox(width: 20.w,),
                      button(context, 'Sign Up', () => Navigator.push(context, MaterialPageRoute(builder: (context) => SignupInfoScreen()))),
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
      required String svgName,
      required BuildContext context}) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 30.h,
          ),
          richText,
          SizedBox(
            height: 350.h,
            width: double.infinity,
            child: SvgPicture.asset(
              "assets/illustrations/$svgName.svg",
              fit: BoxFit.contain,
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
