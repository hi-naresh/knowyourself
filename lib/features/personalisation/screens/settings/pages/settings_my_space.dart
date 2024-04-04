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
            // ElevatedButton(onPressed: backupController.getData(), child: Text('Test')),
            SettingTile(
                title: "Import Data",
                subtitle: "Import data from last account",
                onTap: ()=>backupController.importData(),
                icon: CupertinoIcons.arrow_clockwise),
            SettingTile(
                title: "Export Data",
                onTap: ()=>backupController.exportData(),
                subtitle: "Export data to another account",
                icon: CupertinoIcons.arrow_swap),
            //erase all data
            SettingTile(
                title: "Erase Data",
                onTap: ()=>backupController.eraseData(),
                subtitle: "Erase all data from this account",
                icon: CupertinoIcons.delete_right),
          ],
        ),
      ),
    );
  }
}
