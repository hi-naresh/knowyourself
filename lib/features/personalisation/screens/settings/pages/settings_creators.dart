import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:knowyourself/common/widgets/appbar/appbar.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import 'package:knowyourself/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';
import '../../../../../utils/constants/team.dart';

class CreatorsScreen extends StatelessWidget {
  const CreatorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const KAppBar(
        title: 'Creators',
        back: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(KSizes.md),
        child: ListView.builder(
          itemCount: teamMembers.length,
          itemBuilder: (context, index) {
            final member = teamMembers[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: KSizes.md),
              child: Card(
                color: member.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(KSizes.borderRadiusXl),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(KSizes.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: Colors.white,
                            child: member.imagePath == null
                                ? Text(
                                    member.name.substring(0, 1),
                                    style: const TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: KColors.textPrimary,
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 26,
                                    backgroundColor: Colors.white,
                                    backgroundImage: AssetImage(member.imagePath),
                                  )
                          ),
                          const SizedBox(width: KSizes.defaultSpace),
                          // Text(
                          //   member.name,
                          //   style: const TextStyle(
                          //     fontWeight: FontWeight.bold,
                          //     fontSize: 22,
                          //     color: Colors.white,
                          //   ),
                          // ),
                          //make sure if name is too long , overflow it
                          Expanded(
                            child: Text(
                              member.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: KColors.textPrimary,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                        ],
                      ),
                      const SizedBox(height: KSizes.md),
                      Text(
                        member.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: KSizes.fontSizeMd,
                          color: KColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: KSizes.sm),
                      Row(
                        children: [
                          const Icon(CupertinoIcons.mail_solid , color:KColors.textSecondary),
                          const SizedBox(width: KSizes.sm),
                          Text(
                            member.email,
                            style: const TextStyle(
                              fontSize: KSizes.fontSizeMd,
                              color: KColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: KSizes.md),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: KColors.textPrimary,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(KSizes.borderRadiusXl),
                          ),
                        ),
                        onPressed: () =>KHelper.sendMailTo(member.email),
                        child: const Text(
                          'Contact',
                          style: TextStyle(fontSize: KSizes.fontSizeMd),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
