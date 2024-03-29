import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowyourself/features/master.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
class AuthScreenPrompt extends StatelessWidget {

  const AuthScreenPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(CupertinoIcons.lock_circle_fill, size: KSizes.iconLg*1.6,color: kApp4Light,),
          const SizedBox(height: KSizes.defaultSpace),
          Text.rich(
            textAlign: TextAlign.center,
            TextSpan(
              children: [
                TextSpan(text: "My Space is Locked", style: Theme.of(context).textTheme.headlineSmall),
                TextSpan(
                    text:"\nUse your fingerprint or face ID to view.",
                    style: Theme.of(context).textTheme.labelLarge),
              ],
            ),
          ),
          const SizedBox(height: KSizes.defaultSpace),
          TextButton(
            onPressed: (){
              final masterController = MasterController.instance;
              masterController.authenticateBeforeAccess();
            },
            child: const Text("View My Space", style: TextStyle(color: kApp4Light),),
          ),
        ],
      ),
    );
  }
}