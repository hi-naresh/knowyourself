import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:knowyourself/screens/Main%20Screen/widgets/Bottom%20Nav%20Bar/bottom_nav_bar_widget.dart';

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

    return const Color(0xFFB3B3B7);
  }

  // Color _buildTextColor(int index, BuildContext context) {
  //   if (index == currentIndex) {
  //     return Colors.white;
  //   }

  //   return const Color(0xFFB3B3B7);
  // }

  Widget _buildBottomNavbarWidget(int index, BuildContext context) {
    return Icon(
      items[index].iconData,
      color: _buildIconContainerColor(index, context),
      size: items[index].iconSize,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height.h,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.only(left: 10, right: 10),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(50),
        ),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.1),
            offset: Offset(0.0, 2), //(x,y)
            blurRadius: 21.0,
          ),
        ],
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
                    _buildBottomNavbarWidget(i, context),
                    Text(
                      items[i].title,
                      style: TextStyle(
                          color: _buildIconContainerColor(i, context),
                          fontSize: 11),
                    )
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
