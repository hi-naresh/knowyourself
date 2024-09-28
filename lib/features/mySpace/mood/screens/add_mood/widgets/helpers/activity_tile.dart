import 'package:flutter/material.dart';
import 'package:knowyourself/utils/constants/colors.dart';

import '../../../../../../../common/widgets/my_card.dart';
import '../../../../model/activity_info_model.dart';
class ActivityTile extends StatelessWidget {
  final ActivityModel activity;
  final VoidCallback onTap;

  const ActivityTile({
    super.key,
    required this.activity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(title: activity.title, color: activity.color!, imageUrl: "assets/illustrations/health2.svg",opacity: 0.35 , onTap: onTap, width: 150, height: 150,);
  }
}