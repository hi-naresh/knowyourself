import 'package:flutter/material.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:lottie/lottie.dart';

class GlobalLoadingWidget extends StatelessWidget {
  final String? message;
  final double size;

  const GlobalLoadingWidget({
    super.key,
    this.message,
    this.size = 250.0,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        decoration: BoxDecoration(
          color: KColors.scaffoldLight,
          borderRadius: BorderRadius.circular(KSizes.defaultSpace),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 32.0,
              spreadRadius: 8.0,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Lottie animation
            Lottie.asset(
              'assets/animations/breathe.json', // Path to your Lottie file
              width: size,
              height: size,
              frameRate: FrameRate.max,
              fit: BoxFit.contain, // Try BoxFit.cover or BoxFit.fill if necessary
              alignment: Alignment.center,
            ),
            if (message != null) ...[
              const SizedBox(height: 16.0),
              Text(
                message!,
                style: const TextStyle(fontSize: 16.0, color: Colors.grey),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
