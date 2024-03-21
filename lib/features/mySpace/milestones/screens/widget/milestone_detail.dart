import 'package:flutter/material.dart';
import 'package:knowyourself/utils/constants/colors.dart';
import '../../model/milestone_model.dart';

class MilestoneDetails extends StatelessWidget {
  final MilestoneModel milestoneModel;
  const MilestoneDetails({super.key, required this.milestoneModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 5, top: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Text(
              milestoneModel.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: milestoneModel.isDone
                      ? const Color(0xFFABABAB)
                      : Theme.of(context).textTheme.bodySmall?.color,
                  decoration: milestoneModel.isDone
                      ? TextDecoration.lineThrough
                      : TextDecoration.none),
            ),
          ),
          if (!milestoneModel.isDone)
            Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                  color: Color(0xFFD9D9D9), shape: BoxShape.circle),
            ),
          if (milestoneModel.isDone)
            Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                  color: kPrimaryColor, shape: BoxShape.circle),
              child: Center(
                child: Container(
                  height: 12,
                  width: 12,
                  decoration: const BoxDecoration(
                      color: Color(0xFFFFB47E), shape: BoxShape.circle),
                  child: Center(
                    child: Container(
                      height: 4,
                      width: 4,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
