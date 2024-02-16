import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:knowyourself/screens/Main%20Screen/widgets/Bottom%20Nav%20Bar/bottom_nav_bar_widget.dart';
import 'package:knowyourself/utils/ui_colors.dart';

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

  // Color _buildIconColor(int index, BuildContext context) {
  //   if (index == currentIndex) {
  //     return Colors.white;
  //   }

  //   return const Color(0xFFB3B3B7);
  // }

  Color _buildIconContainerColor(int index, BuildContext context) {
    if (index == currentIndex) {
      return items[index].selectedIconColor;
    }

    return kGreyed;
  }

  // Color _buildTextColor(int index, BuildContext context) {
  //   if (index == currentIndex) {
  //     return Colors.white;
  //   }

  //   return const Color(0xFFB3B3B7);
  // }

  // Widget _buildBottomNavbarWidget(int index, BuildContext context) {
  //   return I(
  //     items[index].icon,
  //     color: _buildIconContainerColor(index, context),
  //     size: items[index].iconSize,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      decoration: const BoxDecoration(
        color: kBottomNav,
        borderRadius: BorderRadius.all(
          Radius.circular(40),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          for (int i = 0; i < items.length; i++)
            GestureDetector(
              onTap: () {
                onChanged(i);
              },
              behavior: HitTestBehavior.opaque,
              child: AnimatedContainer(
                width: 80.w,
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                duration: const Duration(milliseconds: 500),
                curve: Curves.linearToEaseOut,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // _buildBottomNavbarWidget(i, context),
                    SvgPicture.asset(
                      items[i].icon,
                      color: _buildIconContainerColor(i, context),
                      height: 25.h,
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
