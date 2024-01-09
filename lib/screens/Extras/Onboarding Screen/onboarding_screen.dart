import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/screens/Register/LoginScreen.dart';
import 'package:knowyourself/screens/Register/SignUpInfo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:knowyourself/utils/ui_colors.dart';

// ignore: must_be_immutable
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _pageController = PageController();

  final Text onBoardScreen1RichText = const Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: 'Welcome to ',
          style: TextStyle(
            color: Color(0xFF191D21),
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        TextSpan(
          text: 'K',
          style: TextStyle(
            color: Color(0xFFFF5D9C),
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        TextSpan(
          text: 'now ',
          style: TextStyle(
            color: Color(0xFF19C788),
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        TextSpan(
          text: 'Yourself ',
          style: TextStyle(
            color: Color(0xFF0086DF),
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        TextSpan(
          text: 'Better\n',
          style: TextStyle(
            color: Color(0xFF191D21),
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        TextSpan(
          text:  'Embark on a transformative journey with Know Yourself Better, unlocking the tools to illuminate the spark within.',
          style: TextStyle(fontSize: 22.0, fontFamily: 'Poppins', color: Color(0xFF000000)),
        ),
      ],
    ),
  );

  final Text onBoardScreen2RichText = const Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: 'Feel, ',
          style: TextStyle(
            color: Color(0xFFFF5D9C),
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        TextSpan(
          text: 'Track, ',
          style: TextStyle(
            color: Color(0xFF19C788),
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        TextSpan(
          text: 'Thrive. ',
          style: TextStyle(
            color: Color(0xFF0086DF),
            fontSize: 36,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        TextSpan(
          text:   "Capture emotions, track feelings, and gain personalized insights. Empower yourself for a deeper understanding, navigating life's highs and lows.",
          style: TextStyle(fontSize: 22.0, fontFamily: 'Poppins', color: Color(0xFF000000)),
        ),
      ],
    ),
  );

  final Text onBoardScreen3RichText = const Text.rich(
    TextSpan(
      children: [
        TextSpan(
          text: "\nYour path to self-discovery \nawaits—let's start this empowering journey together.",
          style: TextStyle(fontSize: 22.0, fontFamily: 'Poppins', color: Color(0xFF000000)),
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
                    // return const AvatarSelectScreen();
                    return const LoginScreen();
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
                      button(context, 'Login', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen()))),
                      SizedBox(width: 20.w,),
                      button(context, 'Sign Up', () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SignupInfoScreen()))),
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
            child: Image.asset(
              "assets/illustrations/$pngName.png",
              fit: BoxFit.contain,
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}
