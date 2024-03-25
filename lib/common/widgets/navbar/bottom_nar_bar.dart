import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../utils/helpers/helper_functions.dart';
import '/utils/constants/sizes.dart';
import '../../../utils/constants/colors.dart';

class BottomRoundedNavBar extends StatelessWidget {
  final List<BottomNavBarWidget> items;
  final int currentIndex;
  final Function(int index) onChanged;
  final double height;
  const BottomRoundedNavBar(
      {super.key,
      required this.items,
      required this.currentIndex,
      required this.onChanged,
      this.height = 80});

  Color _buildIconContainerColor(int index, BuildContext context) {
    if (index == currentIndex) {
      return items[index].selectedIconColor;
    }
    return Theme.of(context).textTheme.headlineSmall!.color!;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(KSizes.sm),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(KSizes.borderRadiusXxl),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
          child: Container(
            height: height,
            padding: const EdgeInsets.only(left: KSizes.sm, right: KSizes.sm),
            width: double.infinity,
            decoration: BoxDecoration(
              color: KHelper.isDarkMode(context) ? kEmptyProgressDark.withOpacity(0.5) : kEmptyProgress.withOpacity(0.5),
              borderRadius: BorderRadius.circular(KSizes.borderRadiusXxl),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                for (int i = 0; i < items.length; i++)
                  GestureDetector(
                    onTap: () {
                      onChanged(i);
                    },
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          items[i].icon,
                          color: _buildIconContainerColor(i, context),
                          height: KSizes.iconMd,
                        ),
                        const SizedBox(
                          height: KSizes.sm
                        ),
                        Text(
                          items[i].title,
                          style: Theme.of(context).textTheme.labelMedium?.copyWith(
                            color: _buildIconContainerColor(i, context),
                          )
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class BottomNavBarWidget {
  final String icon;
  final String title;
  final double iconSize;
  final Color selectedIconColor;

  const BottomNavBarWidget({
    required this.icon,
    required this.title,
    required this.iconSize,
    required this.selectedIconColor,
  });
}