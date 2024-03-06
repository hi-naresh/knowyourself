import 'dart:ui';

import 'package:flutter/cupertino.dart';

class Styles {
  // static final head = TextStyle(
  //   color: const Color(0xFF191D21),
  //   fontSize: 32,
  //   fontWeight: FontWeight.bold,
  //   fontFamily: 'Poppins',
  // );
  static BoxDecoration containerDecoration(Color color) => BoxDecoration(
    gradient: LinearGradient(
      colors: [color, color.withOpacity(0.5)],
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    ),
    borderRadius: BorderRadius.circular(25),
    boxShadow: [
      BoxShadow(
        color: color.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 10,
        offset: Offset(0, 4),
      ),
    ],
  );
}
