import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:lottie/lottie.dart';

class KAnimationLoader extends StatelessWidget {
  const KAnimationLoader({super.key, required this.text, required this.animation, required this.isFullScreen, required this.showAction, this.actionText, this.onActionPressed});

  final String text;
  final String animation;
  final bool isFullScreen;
  final bool showAction;
  final String? actionText;
  final VoidCallback? onActionPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Lottie.asset(animation, width: 200, height: 200),
          const SizedBox(height: KSizes.defaultSpace),
          Text(text, style: Theme.of(context).textTheme.bodyMedium),
          const SizedBox(height: KSizes.defaultSpace),
          if(showAction)
            TextButton(
              onPressed: onActionPressed,
              child: Text(actionText!, style: Theme.of(context).textTheme.titleMedium),
            ),
        ],
      )
    );
  }
}

class KLoaderScreen{
  void openLoadingDialog(String text, String animation) {
    showDialog(
      context: Get.overlayContext!,
      barrierDismissible: false,
      builder: (_)=> const PopScope(
        canPop: false,
          child: Column(
            children: [
              SizedBox(height: 250),
              KAnimationLoader(text: '',animation: '', isFullScreen: false,showAction: false,),
            ],
          )),
    );
  }
}