import 'package:flutter/material.dart';
import 'package:knowyourself/features/mySpace/digdeeper/screens/shape_paths.dart';

class ShapeHandler {
  final Path path0 = ShapePaths.createPath0();
  final Path path1 = ShapePaths.createPath1();
  final Path path2 = ShapePaths.createPath2();
  final Path path3 = ShapePaths.createPath3();

  String? getTappedShape(Offset tapPosition) {
    if (path0.contains(tapPosition)) {
      return "Harmony";
    } else if (path1.contains(tapPosition)) {
      return "Perfection";
    } else if (path2.contains(tapPosition)) {
      return "Knowledge";
    } else if (path3.contains(tapPosition)) {
      return "Action";
    }
    return null;
  }
}
