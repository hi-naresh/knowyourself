import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowyourself/common/widgets/appbar/appbar.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:lottie/lottie.dart';

import '../../../../../data/helper_service/backup_service/backup_service.dart';
import '../../../../../utils/constants/text_strings.dart';
import '../widgets/settings_tile.dart';

class SettingsMySpace extends StatelessWidget {
  const SettingsMySpace({super.key});

  @override
  Widget build(BuildContext context) {
    final backupController = BackupService.instance;
    return Scaffold(
      appBar: const KAppBar(back: true,),
      body: ListView(
        padding: const EdgeInsets.all(KSizes.md),
        children: [
          Lottie.asset(KImages.mySpaceAnim,
            width: double.infinity,
            repeat: true,
            reverse: true,
            fit: BoxFit.contain,
          ),
          SettingTile(
              title: KTexts.recoverLocalDataTitle,
              subtitle: KTexts.recoverLocalDataSubtitle,
              onTap: ()=>backupController.importData(),
              icon: CupertinoIcons.arrow_clockwise),
          SettingTile(
              title: KTexts.recoverOnlineDataTitle,
              subtitle: KTexts.recoverOnlineDataSubtitle,
              onTap: ()=>backupController.importRemoteData(),
              icon: CupertinoIcons.arrow_2_circlepath_circle),
          SettingTile(
              title: KTexts.backupDataLocallyTitle,
              onTap: ()=>backupController.localStore(),
              subtitle: KTexts.backupDataLocallySubtitle,
              icon: CupertinoIcons.device_phone_portrait),
          SettingTile(
              title: KTexts.backupDataOnlineTitle,
              onTap: ()=>backupController.remoteStore(),
              subtitle: KTexts.backupDataOnlineSubtitle,
              icon: CupertinoIcons.arrow_swap),
          //erase all data
          SettingTile(
              title: KTexts.eraseDataTitle,
              onTap: ()=>backupController.eraseData(),
              subtitle: KTexts.eraseDataSubtitle,
              icon: CupertinoIcons.delete_right),
        ],
      ),
    );
  }
}
