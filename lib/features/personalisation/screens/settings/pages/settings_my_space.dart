import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowyourself/common/widgets/appbar/appbar.dart';
import 'package:knowyourself/utils/constants/image_strings.dart';
import 'package:knowyourself/utils/constants/sizes.dart';
import 'package:lottie/lottie.dart';

import '../../../../../data/helper_service/backup_service/backup_service.dart';
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
              title: "Recover local data",
              subtitle: "Import data from last account",
              onTap: ()=>backupController.importData(),
              icon: CupertinoIcons.arrow_clockwise),
          SettingTile(
              title: "Recover online data",
              subtitle: "Import data from last saved to online",
              onTap: ()=>backupController.importRemoteData(),
              icon: CupertinoIcons.arrow_2_circlepath_circle),
          SettingTile(
              title: "Backup data locally",
              onTap: ()=>backupController.localStore(),
              subtitle: "Store your data on your phone",
              icon: CupertinoIcons.device_phone_portrait),
          SettingTile(
              title: "Backup data online",
              onTap: ()=>backupController.remoteStore(),
              subtitle: "Save your data on cloud",
              icon: CupertinoIcons.arrow_swap),
          //erase all data
          SettingTile(
              title: "Erase Data",
              onTap: ()=>backupController.eraseData(),
              subtitle: "Erase all user data from this account",
              icon: CupertinoIcons.delete_right),
        ],
      ),
    );
  }
}
