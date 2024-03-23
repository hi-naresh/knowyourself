import 'package:flutter/material.dart';
import 'package:knowyourself/utils/helpers/shadow_disabler.dart';
import '../../utils/constants/sizes.dart';

class KStyles {
  KStyles._();
  static BoxDecoration lightToDark(Color c) => BoxDecoration(
    gradient: LinearGradient(
      colors: [ c.withOpacity(0.5), c],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    borderRadius: BorderRadius.circular(KSizes.borderRadiusXl),
  );

  static BoxDecoration darkToLight(Color color) => BoxDecoration(
    gradient: LinearGradient(
      colors: [color, color.withOpacity(0.75)],
      begin: Alignment.topCenter,
      end: Alignment.bottomLeft,
    ),
    boxShadow:CustomShadow.getShadow( [BoxShadow(
      color: color.withOpacity(0.2),
      spreadRadius: 1,
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),]),
    borderRadius: BorderRadius.circular(30),
  );

  static BoxDecoration containerDecoration(Color color) => BoxDecoration(
    gradient: LinearGradient(
      colors: [color, color.withOpacity(0.5)],
      begin: Alignment.topLeft,
      end: Alignment.bottomLeft,
    ),
    boxShadow:CustomShadow.getShadow( [BoxShadow(
          color: color.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),]),
    borderRadius: BorderRadius.circular(25),
  );
}
