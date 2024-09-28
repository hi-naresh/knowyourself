import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowyourself/common/widgets/appbar/appbar.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';
import 'package:lottie/lottie.dart';

import '../../../../../utils/constants/app_links.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../widgets/settings_tile.dart';

class SettingsAboutScreen extends StatelessWidget {
  const SettingsAboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KAppBar(back: true,),
      body: Padding(
        padding: const EdgeInsets.all(KSizes.md),
        child: Column(
          children: [
            Lottie.asset(KImages.mySpaceAnim,
              width: double.infinity,
              repeat: true,
              reverse: true,
              fit: BoxFit.contain,
            ),
            SettingTile(
                title: KTexts.privacyPolicyTitle,
                subtitle: KTexts.privacyPolicySubtitle,
                onTap: () => KHelper.launchUrl(AppLinks.privacy),
                trailing: const Icon(CupertinoIcons.forward),
                icon: CupertinoIcons.doc_text),
            SettingTile(
                title: KTexts.termsOfServiceTitle,
                subtitle: KTexts.termsOfServiceSubtitle,
                onTap: () => KHelper.launchUrl(AppLinks.terms),
                trailing: const Icon(CupertinoIcons.forward),
                icon: CupertinoIcons.settings_solid),
            SettingTile(
                title: KTexts.contactUsTitle,
                subtitle: KTexts.contactUsSubtitle,
                trailing: Icon(CupertinoIcons.forward),
                onTap: () => KHelper.showBottomSheet(contactForm(context)),
                icon: CupertinoIcons.mail),
          ],
        ),
      ),
    );
  }

  Widget contactForm(BuildContext context){
    return SizedBox(
      height: 500,
      child: Padding(
        padding: const EdgeInsets.all(KSizes.defaultSpace),
        child: Column(
            children:[
              Text(
                KTexts.contactUsTitle,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: KSizes.spaceBtwItems),
              Text(
                KTexts.contactUsMessage,
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: KSizes.defaultSpace),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: KTexts.subjectLabel,
                  hintText: KTexts.subjectHint,
                ),
              ),
              const SizedBox(height: KSizes.defaultSpace),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: KTexts.messageLabel,
                  hintText: KTexts.messageHint,
                ),
              ),
              const SizedBox(height: KSizes.defaultSpace*2),

              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  KHelper.showSnackBar(KTexts.successMessage, KTexts.successMessageDescription);
                },
                child: const Text(KTexts.send),
              ),
            ]
        ),
      ),
    );
  }
}
