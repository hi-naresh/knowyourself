import 'package:flutter/material.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';
import 'package:knowyourself/utils/device/device_utility.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Lottie.asset(
            KImages.logoAnim,
            width: 200,
            height: 200,
            repeat: false,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: KDeviceUtils.getScreenHeight() * 0.07),
              child: Image.asset(
                KImages.sailcLogo,
                width: 150,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
