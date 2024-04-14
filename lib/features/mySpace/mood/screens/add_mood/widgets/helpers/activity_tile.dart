import 'package:flutter/material.dart';

import '../../../../../../../common/widgets/my_card.dart';
import '../../../../model/activity_model.dart';
class ActivityTile extends StatelessWidget {
  final Activity activity;
  final VoidCallback onTap;

  const ActivityTile({
    super.key,
    required this.activity,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return MyCard(
      title: activity.title,
      color: activity.color,
      imageUrl: activity.imageUrl, onTap: onTap, width: 150, height: 150,);
  }
}