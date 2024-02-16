import 'package:flutter/cupertino.dart';

import '../../utils/ui_colors.dart';

Widget CustomPlaceHolder(String text, double height, double width) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      color: kPalette6_2,
      borderRadius: BorderRadius.circular(20),
    ),
    margin: EdgeInsets.only(left: 5, right: 5),
    padding: EdgeInsets.only(left: 20, right: 20),
    child: Center(child: Text(text)),
  );
}
